From: Matthias Grimm <matthias.grimm@htp-tel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Any known problems with usleep() in 2.6.7?
Date: Tue, 13 Jul 2004 21:34:57 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200407132134.58687.matthias.grimm@htp-tel.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
Recently I have had a strange phenomenon with kernel 2.6.7: sometimes usleep()
doesn't return. it  hangs. I haven't discovered yet under which circumstances
usleep() doesn't work. With kernel 2.4 I haven't seen this behaviour.

Are there any known problems with usleep() in kernel 2.6.7?
Is there a better method to wait a while?

I attached the code fragment with the problematic usleep() call. that. Maybe
there is something wrong I haven't seen yet. I would appreciate every hint.
I know that I should check the return value of fork() for error but this has
nothing to do with the usleep() problem, because the child has been created.

 Best Regards
    Matthias Grimm

--------------
	pid = fork();
	if (pid == 0) {
		for (i=0; i < maxfiles; i++)
			close(i);      /* close all possible file handles */

		open("/dev/null", O_RDONLY);  /* STDIN */
		open("/dev/null", O_WRONLY);  /* STDOUT */
		open("/dev/null", O_WRONLY);  /* STDERR */

		execv(argv[0], argv);
		exit(99);
	}
	rc = E_CLDKILL;
	for (i=base->timeforcmd * 10; i > 0; i--) {
		usleep(100000);  /* sleep 100ms */
		if (waitpid (pid, &status, WNOHANG)) {
			if (WIFEXITED(status)) {
				if ((base->rc = WEXITSTATUS(status)))
					rc = E_CLDEXIT;
				else
					rc = 0;
			} else if (WIFSIGNALED(status))
				rc = E_CLDSIG;
			break;
		}
	}
	if (i == 0)
		kill (pid, SIGKILL);
---------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
** This list is shutting down 7/24/2004.
