Message-ID: <3B648DC5.9050009@hadess.net>
Date: Sun, 29 Jul 2001 23:27:17 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: userspace button controls
References: <20010724015531.516c9985.jpgarcia@execpc.com>	<3B63877E.9060001@hadess.net> <20010729010905.3faf9642.jpgarcia@execpc.com>
Content-Type: multipart/mixed;
 boundary="------------090703020504000908010006"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------090703020504000908010006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Woop,

So after a session of IRC, and some nasty clock problems, Joseph and I
(especially Joseph in fact ;) managed to get this working alright on an
iBook2. I attach a newer working version of keyevd that Joseph fixed
after my previous post, and to which I added eject (uses the eject
utility somewhere in your PATH).

buttons2.patch installs on top of Jospeh's buttons.patch
keyevd2.c: compiles with:
gcc -I/usr/src/linux/include/ -o keyevd2 `glib-config --cflags`
`glib-config --libs` -lpopt keyevd2.c

keyevd2.c is still a abominable hack, it needs some major cleaning up

Have fun

Joseph P. Garcia wrote:

>Greetings.
>
>On Sun, 29 Jul 2001 04:48:14 +0100
>Bastien Nocera <hadess@hadess.net> wrote:
>
>>Well, the buttons_patch doesn't work on the ibook2:
>>
>[...]
>
>>eject: Unhandled button code 0b
>>
>
>Perfect!  This is what I was looking for.  Attached is a patch to make things work... maybe.  I don't know what to expect with the power key.  The eject key on the iBook2 is apparantly still an adb-button... neato.. i think.
>
>You will probably get an 'unknown scancode' for the eject key, but you can get the idea how to fix that from the patch.  change the cooresponding 0 to a KEY_EJECTCD, recompile, and it should work.  I don't know what exactly to expect from it.
>
>BTW, I contacted James Simmons, a developer in linuxconsole and framebuffer.  He mentioned that this sort of thing (fb-backlight, new input keys) are planned for 2.5.x.  Which makes sense, as volume/eject keys are no big diff at the moment, but, as Michael Schmitz pointed out, the backlight-related changes should not be introduced under the table.
>
>So volume keys and eject key (power too?) should be merge-able after completion and some testing.
>
>Thanks for your help.
>
> eject.patch
>
> Content-Type:
>
> application/octet-stream
> Content-Encoding:
>
> base64
>
>


--------------090703020504000908010006
Content-Type: text/plain;
 name="buttons2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="buttons2.patch"

diff -urN linux-benh/drivers/macintosh/adbhid.c linux-benh.new/drivers/macintosh/adbhid.c
--- linux-benh/drivers/macintosh/adbhid.c	Tue Jul 11 12:53:57 1933
+++ linux-benh.new/drivers/macintosh/adbhid.c	Sun Jul 29 23:14:17 2001
@@ -493,6 +493,7 @@
 			set_bit(KEY_VOLUMEDOWN, adbhid[id]->input.keybit);
 			set_bit(KEY_BRIGHTNESSUP, adbhid[id]->input.keybit);
 			set_bit(KEY_BRIGHTNESSDOWN, adbhid[id]->input.keybit);
+			set_bit(KEY_EJECTCD, adbhid[id]->input.keybit);
 			break;
 		}
 		if (adbhid[id]->name[0])
diff -urN linux-benh/drivers/macintosh/mac_hid.c linux-benh.new/drivers/macintosh/mac_hid.c
--- linux-benh/drivers/macintosh/mac_hid.c	Tue Jul 11 12:53:57 1933
+++ linux-benh.new/drivers/macintosh/mac_hid.c	Tue Jul 11 13:17:59 1933
@@ -204,7 +204,7 @@
 	0, 0, 0, 0, 0, KEY_VOLUMEDOWN, KEY_MUTE, 0,					/* 0x20-0x27 */
 	0, 0, 0, 0, 0, 0, 0, 0,					/* 0x28-0x2f */
 	0, 0, 0, 0, 0, KEY_KPSLASH, 0, KEY_SYSRQ,		/* 0x30-0x37 */
-	KEY_RIGHTALT, KEY_BRIGHTNESSUP, KEY_BRIGHTNESSDOWN, 0, 0, 0, 0, 0,			/* 0x38-0x3f */
+	KEY_RIGHTALT, KEY_BRIGHTNESSUP, KEY_BRIGHTNESSDOWN, KEY_EJECTCD, 0, 0, 0, 0,			/* 0x38-0x3f */
 	0, 0, 0, 0, 0, 0, 0, KEY_HOME,				/* 0x40-0x47 */
 	KEY_UP, KEY_PAGEUP, 0, KEY_LEFT, 0, KEY_RIGHT, 0, KEY_END, /* 0x48-0x4f */
 	KEY_DOWN, KEY_PAGEDOWN, KEY_INSERT, KEY_DELETE, 0, 0, 0, 0, /* 0x50-0x57 */
diff -urN linux-benh/drivers/video/aty128fb.c linux-benh.new/drivers/video/aty128fb.c
--- linux-benh/drivers/video/aty128fb.c	Mon Jul 10 23:06:46 1933
+++ linux-benh.new/drivers/video/aty128fb.c	Sun Jul 29 22:24:31 2001
@@ -1921,6 +1921,10 @@
     /* turn off bus mastering, just in case */
     aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL) | BUS_MASTER_DIS);

+#ifdef CONFIG_FB_BACKLIGHT
+    info->backlight_level=FBBACKLIGHT_MAX;
+#endif
+
     aty128fb_set_var(&var, -1, &info->fb_info);
     aty128_init_engine(&info->default_par, info);

@@ -1937,9 +1941,6 @@
 	    pmu_register_sleep_notifier(&aty128_sleep_notifier);
     }
 #endif
-#ifdef CONFIG_FB_BACKLIGHT
-	info->backlight_level=FBBACKLIGHT_MAX;
-#endif

     printk(KERN_INFO "fb%d: %s frame buffer device on %s\n",
 	   GET_FB_IDX(info->fb_info.node), aty128fb_name, name);
@@ -2523,6 +2524,8 @@
 aty128_set_backlight(int on, int level, struct fb_info_aty128* info)
 {
 	unsigned int reg = aty_ld_le32(LVDS_GEN_CNTL);
+
+	info->backlight_level = level;

 	if (!info->lcd_on)
 		on = 0;

--------------090703020504000908010006
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

#define DEBUG

gchar *mixername = NULL;
gchar *fbname = NULL;
gboolean use_alsa = FALSE;
gboolean show_help = FALSE;

enum actions {
	VOLUME_UP,
	VOLUME_DOWN,
	VOLUME_MUTE,
	BACKLIGHT_UP,
	BACKLIGHT_DOWN,
	EJECT_CD
};

struct poptOption options[] = {
	{
	 "alsa",
	 'a',
	 POPT_ARG_NONE,
	 &use_alsa,
	 0,
	 "Use ALSA mixer instead of OSS mixer",
	 NULL},
	{
	 "mixer",
	 'm',
	 POPT_ARG_STRING,
	 &mixername,
	 0,
	 "Use a device other than /dev/mixer for the volume control",
	 "MIXER"},
	{
	 "fb",
	 'f',
	 POPT_ARG_STRING,
	 &fbname,
	 0,
	 "Use a device other than /dev/fb for the backlight control",
	 "FB"},
	POPT_AUTOHELP {NULL, 0, 0, NULL, 0}
};

static void quit(gint i, gchar * msg)
{
	g_print("%s\n", msg);
	exit(i);
}

static void do_signal(gint signum)
{
	gchar *msg = 0;

	/* There's a leak here, but we don't care since we're
	 * quitting the app */
	g_strdup_printf("Caught signal %d", signum);
	quit(signum == SIGTERM ? 0 : -1, msg);
}

#define open_action_dev(x) open(x,O_RDONLY)

static void volume_actions_oss(int action)
{
#ifdef SINGLE_CHANNEL
#define CHANNEL SOUND_MIXER_VOLUME
	static int mute = 0;
#else
#define CHANNELS 2
	static int channel[CHANNELS] =
	    { SOUND_MIXER_VOLUME, SOUND_MIXER_SPEAKER };
	static int channelidx = 0;
#define CHANNEL channel[channelidx]
#endif
	int actionfd;
	static int vol = 0;
	int parm;

	actionfd = open_action_dev(mixername);
	switch (action) {
#ifdef SINGLE_CHANNEL
	case VOLUME_UP:
		if (!mute) {
			ioctl(actionfd, MIXER_READ(CHANNEL), &vol);
			vol = (vol & 0xff) + 8;
			if (vol > 100)
				vol = 100;
			vol |= vol << 8;
		}		//dont increment if unmute from press
		mute = 0;
		parm = vol;
		break;
	case VOLUME_DOWN:
		ioctl(actionfd, MIXER_READ(CHANNEL), &parm);
		if (parm || mute) {	//if we aren't muted anymore or we think we are muted
			mute = 0;	//not muted now
			if (parm) {	//weren't anyway
				vol = parm;
				vol = (vol & 0xff) - 8;
				if (vol < 0)
					vol = 0;
				vol |= vol << 8;
			}	//dont decrement if unmuting due to press
			parm = vol;
		} else {	//no vol and no mute... we're mute now..
			mute = 1;
			parm = 0;
		}
		break;
	case VOLUME_MUTE:
		if (!mute) {
			ioctl(actionfd, MIXER_READ(CHANNEL), &parm);
			if (!parm) {	//already muted and we didn't know it
				parm = vol;	//if vol==0, it was deliberate.
				mute = 0;
			} else {	//have volume.  mute
				vol = parm;
				parm = 0;
				mute = 1;
			}
		} else {
			parm = vol;
			mute = 0;
		}
		break;
#else
	case VOLUME_UP:
		vol = (vol & 0xff) + 8;
		if (vol > 100)
			vol = 100;
		vol |= vol << 8;
		break;
	case VOLUME_DOWN:
		vol = (vol & 0xff) - 8;
		if (vol < 0)
			vol = 0;
		vol |= vol << 8;
		break;
	case VOLUME_MUTE:
		ioctl(actionfd, MIXER_READ(CHANNEL), &vol);
		parm = 0;
		ioctl(actionfd, MIXER_WRITE(CHANNEL), &parm);
		channelidx = (channelidx + 1) % CHANNELS;
		parm = vol;
		break;
#endif
	}
	ioctl(actionfd, MIXER_WRITE(CHANNEL), &parm);
	close(actionfd);
}

static void backlight_actions(int action)
{
	int actionfd;
	__u32 bklight;
	int foo;

	actionfd = open_action_dev(fbname);
	ioctl(actionfd, FBIOGET_BACKLIGHT, &bklight);
	switch (action) {
	case BACKLIGHT_UP:
		bklight++;
		if (bklight > FBBACKLIGHT_MAX)
			bklight = FBBACKLIGHT_MAX;
		break;
	case BACKLIGHT_DOWN:
		if (bklight > FBBACKLIGHT_OFF)
			bklight--;
		break;
	}
	foo = ioctl(actionfd, FBIOSET_BACKLIGHT, &bklight);
	if (foo <0)
		perror("keyevd");
	close(actionfd);
}

int main(int argc, const char **argv)
{
	poptContext pctx;
	int eventfd = -1;
	struct input_event inp;
	struct sigaction sigpipe = { {SIG_IGN}, {{0}}, SA_RESTART, 0 };
	struct sigaction sigterm = { {do_signal}, {{0}}, SA_RESTART, 0 };
	short ids[4];
	char *filename;

	int i;

	pctx = poptGetContext(NULL, argc, argv, options, 0);

	while ((i = poptGetNextOpt(pctx)) != -1) {	//everything should be handled
		poptStrerror(i);
		printf("%s: %s (-? for help)\n", poptStrerror(i),
		       poptBadOption(pctx, 0));
		exit(0);
	}
	if (mixername == NULL) {
		if (use_alsa == FALSE)
			mixername = g_strdup("/dev/mixer");
		else
			g_print("somebody please fix this ;)\n");
	}
	if (fbname == NULL)
		fbname = g_strdup("/dev/fb0");

	if (sigaction(SIGTERM, &sigterm, 0))
		quit(-1, "could not install SIGTERM handler");

	if (sigaction(SIGPIPE, &sigpipe, 0))
		quit(-1, "could not install SIGPIPE handler");

	for (i = 0; i < 32; i++) {
		filename = g_strdup_printf("/dev/input/event%i", i);
		eventfd = open(filename, O_RDONLY);
		if (eventfd >= 0) {
			ioctl(eventfd, EVIOCGID, ids);
			if ((ids[2] & 0xfff) == 0x71f) {
				printf("Powerbook Button device found at event%i.\n",
				       i);
				syslog(LOG_INFO,
				       "Powerbook Button device found at event%i.\n",
				       i);
				break;
			}
#ifdef DEBUG
			fprintf(stderr, "[%x] ids - %x %x %x %x\n", i,
				ids[0], ids[1], ids[2], ids[3]);
#endif
			close(eventfd);
			eventfd = -1;
		}
#ifdef DEBUG
		else {
			fprintf(stderr, "[%x] nil\n", i);
		}
#endif
	}
	if (eventfd < 0) {
		printf("Powerbook Button event device not found.\n");
		exit(-1);
	}
#ifndef DEBUG
	{
		int pid = fork();

		if (pid < 0) {
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
	while (read(eventfd, &inp, sizeof(inp))) {
		if (inp.value) {
			g_print("Event %0x caught\n", inp.code);
			switch (inp.code) {
			case KEY_MUTE:
				if (inp.value == 2)
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
				backlight_actions(BACKLIGHT_DOWN);
				break;
			case KEY_BRIGHTNESSUP:
				backlight_actions(BACKLIGHT_UP);
				break;
			case KEY_EJECTCD:
				system("eject");
				break;
			}
		}
	}
	close(eventfd);
	return 0;
}

--------------090703020504000908010006--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
