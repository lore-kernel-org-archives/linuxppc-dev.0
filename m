Message-ID: <C08678384BE7D311B4D70004ACA3710511194635@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Chris Wedgwood'" <cw@f00f.org>, Mark Chambers <markc@mail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Control-C in bash ???
Date: Mon, 13 Jan 2003 12:59:04 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Here is some code which is The Wrong Answer (the
right answer being, use Denk's SELF & ELDK and you
will have no worries or problems in life).

Nonetheless, this Wrong Answer is illuminating
in that it shows the essentials of what needs
to happen.




// John Kerl
// Avnet Design Services
// 2002/03/27

// ttyrun.c:
// Runs a program with the terminal set up correctly for job control.
// * Compile with powerpc-linux-gcc ttyrun.c -o ttyrun
// * Run in /etc/rc.whatever as ttyrun {program name} {arguments ...},
//   e.g. /bin/ttyrun /bin/sh.

#include <stdio.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <signal.h>
#include <termios.h>
#include <unistd.h>
#include <sys/ioctl.h>

// ----------------------------------------------------------------
void run_prog(int nargc, char ** nargv, char ** oenvp)
{
	char * envs[] = {
		"HOME=/", "TERM=linux", "PATH=/bin", "LD_LIBRARY_PATH=/lib",
		"PS1=temp# ", 0
	};
	char * nenvp[8];

	nenvp[0] = envs[0];
	nenvp[1] = envs[1];
	nenvp[2] = envs[2];
	nenvp[3] = envs[3];
	nenvp[4] = envs[4];
	nenvp[5] = envs[5];

	if (execve(nargv[0], nargv, oenvp) < 0)
		perror("execve");
}

// ----------------------------------------------------------------
int main(int argc, char ** argv, char ** envp)
{
	char tty_name[] = "/dev/ttyS0";
	int tty_fd;
	int pid;
	int pgrp;
	int ppgrp;
	int ttypgrp = -2;

	if (argc < 2) {
		fprintf(stderr, "Usage: %s {program name}\n", argv[0]);
		exit(1);
	}

	tty_fd = open(tty_name, O_RDWR);
	if (tty_fd < 0) {
		perror("open tty");
		exit(1);
	}

	// Only go through this trouble if the new
	// tty doesn't fall in this process group.
	pid = getpid();
	pgrp = getpgid(0);
	ppgrp = getpgid(getppid());
	if (ioctl(tty_fd, TIOCGPGRP, &ttypgrp) < 0) {
		perror("ioctl TIOCGPGRP");
	}

	if (pgrp != ttypgrp && ppgrp != ttypgrp) {
		if (pid != getsid(0)) {
			if (pid == getpgid(0))
				setpgid(0, getpgid(getppid()));
			setsid();
		}

		signal(SIGHUP, SIG_IGN);
		ioctl(0, TIOCNOTTY, (char *)1);
		signal(SIGHUP, SIG_DFL);
		close(0);
		close(1);
		close(2);
		close(tty_fd);
		tty_fd = open(tty_name, O_RDWR);
		ioctl(0, TIOCSCTTY, (char *)1);
		dup(tty_fd);
		dup(tty_fd);
	}
	else {
		close(tty_fd);
	}

	run_prog(argc - 1, &argv[1], envp);

	return 0;
}





-----Original Message-----
From: Chris Wedgwood [mailto:cw@f00f.org]
Sent: Monday, January 13, 2003 12:49 PM
To: Mark Chambers
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Control-C in bash ???



On Mon, Jan 13, 2003 at 02:09:00PM -0500, Mark Chambers wrote:

> On a PC, I can, for instance, enter "ping 192.168.1.4", then hit
> Control-C and stop the ping.  For the life of me, I can't figure out
> how to do the same on my MPC860 system!!!

if you boot init=/bin/sh or whatever and your init/login doesn't set
the tty up, you will need to do it yourself (man stty).


  --cw


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
