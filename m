From: hollis@andrew.cmu.edu
Message-ID: <37F78356.5D7C54DF@andrew.cmu.edu>
Date: Sun, 03 Oct 1999 12:24:54 -0400
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: trouble with open()
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, maybe I'm just being really stupid, but the following code isn't
working for me.

I'm trying to open /dev/dsp. The file descriptor returned by open is 0,
which is supposed to be stdin, right? Anyways, a subsequent call to
ioctl doesn't like fd 0 either.

[dev->path = "/dev/dsp"]

    printf("attmpting to open %s\n", dev->path);
    if (dev->dev_fd = open(dev->path, O_RDWR) < 0) {
        perror(dev->path);
        fprintf(stderr, "Couldn't open audio device %s!\n", dev->path);
        return -1;
    }
    printf("dev_fd = %i\n", dev->dev_fd);

When I run this code, my output is:
attempting to open /dev/dsp
dev_fd = 0

The permissions are set fine, and I get the same problem with
/dev/audio.

What am I doing wrong? I ask because I'm a little frustrated at this
point.

-Hollis

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
