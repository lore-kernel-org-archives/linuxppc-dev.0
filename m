Date: Fri, 4 Feb 2000 19:55:22 -0800 (PST)
From: Brad Midgley <brad@turbolinux.com>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] little-endian dmasound silently fails
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000204175200.3438D-100000@ofey.inetnebr.com>
Message-ID: <Pine.LNX.4.20.0002041952120.32666-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> How does it write "little-endian data"?  Does the program take care of CPU
> being big-endian in some way?  If not, I'd think it's the program's fault.

the api provides for a way for clients to set the driver to accept
little-endian data. worse than simply not implementing it, dmasound also
makes it *appear* that it implements it.

#include <stdio.h>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/soundcard.h>

void die(char *m) {
  printf("%s\n", m);
  exit(1);
}

int main(int argc, char *argv[]) {
  int fd, bytesex;

  fd = open("/dev/dsp", O_WRONLY);
  if(fd < 0) die("couldn't open /dev/dsp");

  bytesex = AFMT_S16_LE;
  if(ioctl(fd, SNDCTL_DSP_SETFMT, &bytesex))
    die("little-endian sound isn't implemented in this driver\n");

  printf("supposedly the sound driver supports little-endian data. :(\n");

  return 0;
}


Brad
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
