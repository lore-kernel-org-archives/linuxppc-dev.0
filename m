Message-Id: <200006182257.AAA00912@piglet.grunz.lu>
Date: Mon, 19 Jun 2000 00:57:42 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Problems handling large files??
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I've come across another problem in the 2.3.99 kernels (I've not had a
chance to try 2.4.0-test). This is with 2.3.99-pre9 from Paul's rsync.

Whenever a file larger than a few megabytes is created, the system will
report 'out of memory' errors at random file syizes, while writing the
file.

I'v seen it while unpacking the XFree4 sources (three files over 10 MB
each), and now while running bonnie (should be run with 100-200 MB
depending on RAM).

I got by the XFree problem by running rpm -u multiple times in a row on
the source rpm, until it succeeded.

However, with bonnie, I've not ben able to create files larger than 60
MB (there's plenty of room on the device...). Here is the result from
bonnie's attempts to create large files, all got errors:

-rwxrwx---   1 mlan     users    60620800 Jun 19 00:44 Bonnie.883
-rwxrwx---   1 mlan     users     6524928 Jun 19 00:44 Bonnie.885
-rwxrwx---   1 mlan     users     4177920 Jun 19 00:45 Bonnie.887
-rwxrwx---   1 mlan     users     8466432 Jun 19 00:45 Bonnie.889
-rwxrwx---   1 mlan     users    14770176 Jun 19 00:45 Bonnie.891
-rwxrwx---   1 mlan     users    30285824 Jun 19 00:45 Bonnie.893
-rwxrwx---   1 mlan     users    15667200 Jun 19 00:51 Bonnie.901
-rwxrwx---   1 mlan     users     3592192 Jun 19 00:51 Bonnie.905

Here's the exact error message:

File '/mnt/testdrive/Bonnie.905', size: 104857600
Writing with putc()...Bonnie: drastic I/O error (putc): Cannot allocate memory

Here's the relevant code leading to the error:

  /* Fill up a file, writing it a char at a time with the stdio putc() call */
  fprintf(stderr, "Writing with putc()...");
  newfile(name, &fd, &stream, 1);
  timestamp();
  for (words = 0; words < size; words++)
    if (putc(words & 0x7f, stream) == EOF)
      io_error("putc");

static void
io_error(char * message)
{
  char buf[Chunk];

  sprintf(buf, "Bonnie: drastic I/O error (%s)", message);
  perror(buf);
  exit(1);
}

So the 'Cannot allocate memory' comes from the system (libc? system
call?).

Anybody know what's going on? Can you verify this on a 2.4.0-test
kernel? FWIW, bonnie _was_ working OK on 2.2.13 (later unverified) and
2.3.48 (latest benchamrk I have).

Clues?

Thanks
		Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
