Message-ID: <3B5DB0EF.7000804@hadess.net>
Date: Tue, 24 Jul 2001 18:31:27 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: userspace button controls
References: <20010724015531.516c9985.jpgarcia@execpc.com>
Content-Type: multipart/mixed;
 boundary="------------010407020208020405010507"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------010407020208020405010507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Joseph P. Garcia wrote:

> attached is a tar.gz of a few files I've created as a solution to powerbook buttons.
>
> - buttons.patch: brings all 5 adb-buttons to userspace via NIL's events via the keyboard.  New keys added to input.h.  With proper support, the user could see these keypresses, and use them.  This also does not use the pmac_backlight.c file, in exchange for a new framebuffer ioctl, existant in chipsfb, atyfb, and aty128fb.  The only interdependancy is between chipsfb/atyfb and via-pmu for backlight control for lombard and earlier.  The pmu's backlight ioctl was removed.  So sound controls are in the mixer (unchanged), backlight controls are in the fb rather than pmu, and the adbbuttons are simple keys, accessed via /dev/input/event? and, with some help, common console/X keycodes.  syslog logs an error with there is no keycode.  I changed that to a DEBUG message rather than a WARNING message.
>
> - adbhid_sleep.patch: checks before an adbhid is deregistered post sleep.  The existing code causes an open event device to dangle open (safely i think), but the program doesn't notice it.  This checks to see if the device has changed, or no longer exists before it deregisters it.  This works for me, but might be unsafe.  I couldn't find a cleaner solution that still allows for reprobing.
>
> - input_sec.patch: Fix permissions for input devices created via devfs, which are default readable by anyone, including the keyboard's event dev. (submitted to maintainer)
>
> - misc.patch: one fix (missing non-fatal include in checks.c), and a slightly cleaner non-TAU temp coding.  (irrelevant to button operations)
>
> - keyevd.c: a quick daemon that listens to the buttons and acts on them.  Simple compile builds a forking daemon that uses the mute button to switch between muting speaker and line out.  Key repeat is too quick tho.  Mostly a quick hack, not too clean.  This needs input event support.

Done a new version of it:

- uses glib
- uses popt
- room for alsa compat
- broke it
- not tested
- really not tested, developed on a x86
- I should be working now

Cheers

--
/Bastien Nocera
http://hadess.net

--------------010407020208020405010507
Content-Type: text/plain;
 name="keyevd2.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="keyevd2.c"

#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <glib.h>
#include <popt.h>
#include <linux/version.h>
#include <sys/ioctl.h>
#include <signal.h>
#include <syslog.h>
#include <linux/input.h>
#include <linux/soundcard.h>
#include <linux/fb.h>
#include <linux/types.h>

gchar *mixername = NULL;
gchar *fbname = NULL;
gboolean use_alsa = FALSE;

enum actions {
	VOLUME_UP,
	VOLUME_DOWN,
	VOLUME_MUTE,
	BACKLIGHT_UP,
	BACKLIGHT_DOWN
};

struct poptOption options[] = {
	{
		"alsa",
		'a',
		POPT_ARG_NONE,
		&use_alsa,
		0,
		"Use ALSA mixer instead of OSS mixer",
		NULL
	},
	{
		"mixer",
		'm',
		POPT_ARG_STRING,
		&mixername,
		0,
		"Use a device other than /dev/mixer for the volume control",
		"MIXER"
	},
	{
		"fb",
		'f',
		POPT_ARG_STRING,
		&fbname,
		0,
		"Use a device other than /dev/fb0 for the backlight control",
		"FB"
	},
	{ NULL, 0, 0, NULL, 0 }
};

static void quit(gint i, gchar *msg)
{
  g_print("%s\n",msg);
  exit(i);
}

static void do_signal(gint signum)
{
	gchar *msg;

	/* There's a leak here, but we don't care since we're
	 * quitting the app */
	g_strdup_printf("Caught signal %d", signum);
	quit(signum == SIGTERM ? 0 : -1, msg);
}

static int open_action_dev(gchar *device)
{
	int fd;

	fd = open(device, O_RDONLY);
	return fd;
}

static void volume_actions_oss(int action)
{
	int actionfd;
	int vol;
#define CHANNELS 2
	int channel[CHANNELS]={SOUND_MIXER_VOLUME,SOUND_MIXER_SPEAKER};
	int channelidx=0;
#define CHANNEL channel[channelidx]
	int mute=0;
	int parm;

	actionfd = open_action_dev(mixername);
	switch (action)
	{
#ifdef SINGLE_CHANNEL
	case VOLUME_UP:
		ioctl(actionfd,MIXER_READ(CHANNEL),&vol);
		mute=1;
		vol=(vol&0xff)+8;
		if(vol>100)
			vol=100;
		vol|=vol<<8;
		parm=vol;
		break;
	case VOLUME_DOWN:
		ioctl(actionfd,MIXER_READ(CHANNEL),&parm);
		if(parm||mute){
			mute=0;
			if(parm)
				vol=parm;
			vol=(vol&0xff)-8;
			if(vol<0)
				vol=0;
			vol|=vol<<8;
		} else {
			mute=1;
		}
		parm=vol;
		break;
		case VOLUME_MUTE:
			if(!mute){
				parm=0;
				mute=1;
			} else {
				parm=vol;
				mute=0;
			}
			break;
#else
		case VOLUME_UP:
			vol=(vol&0xff)+8;
			if(vol>100)
				vol=100;
			vol|=vol<<8;
			break;
		case VOLUME_DOWN:
			vol=(vol&0xff)-8;
			if(vol<0)
				vol=0;
			vol|=vol<<8;
			break;
		case VOLUME_MUTE:
			parm=0;
			ioctl(actionfd,MIXER_WRITE(CHANNEL),&parm);
			parm=0;
			ioctl(actionfd,MIXER_WRITE(CHANNEL),&parm);
			channelidx = (channelidx+1)%CHANNELS;
#endif
	}
	ioctl(actionfd,MIXER_WRITE(CHANNEL),&parm);
	close(actionfd);
}

static void backlight_actions(int action)
{
	int actionfd;
	__u32 bklight;

	actionfd = open_action_dev(fbname);
	ioctl(actionfd,FBIOGET_BACKLIGHT,&bklight);
	switch(action)
	{
	case BACKLIGHT_UP:
		bklight++;
		if(bklight>FBBACKLIGHT_MAX)
			bklight=FBBACKLIGHT_MAX;
		break;
	case BACKLIGHT_DOWN:
		if(bklight>FBBACKLIGHT_OFF)
			bklight--;
		break;
	}
	ioctl(actionfd,FBIOSET_BACKLIGHT,&bklight);
	close(actionfd);
}

int main(int argc, const char **argv)
{
  poptContext pctx;
  const char **args;
  int eventfd; //,actionfd;
  struct input_event inp;
  struct sigaction sigpipe = { {SIG_IGN}, {{0}}, SA_RESTART, 0 };
  struct sigaction sigterm = {{do_signal}, {{0}}, SA_RESTART , 0 };
  short ids[4];
  char *filename; //[50];
//  int vol;
#define CHANNELS 2
  int channel[CHANNELS]={SOUND_MIXER_VOLUME,SOUND_MIXER_SPEAKER};
  int channelidx=0;
#define CHANNEL channel[channelidx]
//  int mute=0;
  int parm;
//  __u32 bklight;

  int i;

  pctx = poptGetContext(NULL, argc, argv, options, 0);
  args = poptGetArgs(pctx);
  if (mixername == NULL)
  {
	  if (use_alsa == FALSE)
		  mixername = g_strdup("/dev/mixer");
	  else
		  g_print("somebody please fix this ;)\n");
  }
  if (fbname == NULL)
	  fbname = g_strdup("/dev/fb0");

  if(sigaction(SIGTERM, &sigterm, 0))
	quit(-1, "could not install SIGTERM handler");

  if(sigaction(SIGPIPE, &sigpipe, 0))
	quit(-1, "could not install SIGPIPE handler");

  for(i=0;i<32;i++){
	filename = g_strdup_printf("/dev/input/event%i",i);
	eventfd = open(filename, O_RDONLY);
	if(eventfd>=0){
	  ioctl(eventfd, EVIOCGID, ids);
	  if((ids[2]&0xfff)==0x71f){
		syslog(LOG_INFO, "Powerbook Button device found at event%i.\n",i);
		break;
	  }
#ifdef DEBUG
	  fprintf(stderr,"[%x] ids - %x %x %x %x\n",i,ids[0],ids[1],ids[2],ids[3]);
#endif
	  close(eventfd);
	  eventfd=-1;
	}
#ifdef DEBUG
	else{
	  fprintf(stderr,"[%x] nil\n",i);
	}
#endif
  }
  if(eventfd<0){
	syslog(LOG_INFO, "Powerbook Button device not found.\n");
	exit(-1);
  }
#if 1
  {
	int pid = fork();

	if(pid < 0){
	  printf("Couldn't fork\n");
	  exit(-1);
	}
	if (pid > 0)
	  quit(0, "parent exiting [note PID]");

	chdir("/");
	setsid();
	close(0);
	close(1);
	close(2);
  }
#endif
  while(read(eventfd,&inp,sizeof(inp))){
	if(inp.value)
	  switch(inp.code){
	  case KEY_MUTE:
		if(inp.value==2)
		  continue;
		if (!use_alsa)
			volume_actions_oss(VOLUME_MUTE);
		else
			g_print("fixme\n");
		break;
	  case KEY_VOLUMEDOWN:
		if (!use_alsa)
			volume_actions_oss(VOLUME_DOWN);
		else
			g_print("fixme\n");
		break;
	  case KEY_VOLUMEUP:
		if (!use_alsa)
			volume_actions_oss(VOLUME_UP);
		else
			g_print("fixme\n");
		break;
	  case KEY_BRIGHTNESSDOWN:
		backlight_actions(BACKLIGHT_UP);
		break;
	  case KEY_BRIGHTNESSUP:
		backlight_actions(BACKLIGHT_DOWN);
		break;
	  }
  }
  close(eventfd);
}

--------------010407020208020405010507--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
