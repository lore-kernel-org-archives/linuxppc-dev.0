Message-ID: <01C1B626.24D9F1C0.svacca@valcom.com>
From: Steven Vacca <svacca@valcom.com>
Reply-To: "svacca@valcom.com" <svacca@valcom.com>
To: "LinuxEmbeddedMailList (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Unbuffered char reads from App from stdin (keyboard)
Date: Fri, 15 Feb 2002 13:39:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Mark,

Using some of your unbuf_getch() code inside a while (1)
loop, fgetc() still blocks until a '\n', then, with each iteration
of the loop, 1 char is returned from the fgetc() until all chars are
returned, then fgetc() blocks again.

Is there a way to get chars without blocking and waiting for
the '\n'?

Thanks,

ShutEyeThinkin





//*************************************************************************
***********
Mark's code:

Hi,

I found some examples on groups.google.com that I modified
to suite my needs.  Try something like these:

int
unbuf_getch()
{
    FILE    *input;
    int      selected;
    struct termios initial_settings;
    struct termios new_settings;

    if (!isatty(fileno(stdout))) {
        fprintf(stderr,"You are not a terminal, OK.\n");
    }

    input = fopen("/dev/tty", "r");
    if(!input) {
        fprintf(stderr, "Unable to open /dev/tty\n");
        exit(1);
    }

    tcgetattr(fileno(input),&initial_settings);
    new_settings = initial_settings;
    new_settings.c_lflag &= ~ICANON;
    new_settings.c_lflag &= ~ECHO;
    new_settings.c_cc[VMIN] = 1;
    new_settings.c_cc[VTIME] = 0;
    new_settings.c_lflag &= ~ISIG;
    if(tcsetattr(fileno(input), TCSANOW, &new_settings) != 0) {
        fprintf(stderr,"could not set attributes\n");
    }
    selected = fgetc(input);
    tcsetattr(fileno(input),TCSANOW,&initial_settings);

    fclose(input);
    return selected;
}

int
kbhit()
{
   int ret, c;
   fd_set read_file_descr;
   struct timeval timeout;
   int debug_flag;

   /* this could be a global */
   debug_flag = 0;

   /* this macro initializes the file descriptor read_file_descr to to be
the empty set */
   FD_ZERO(&read_file_descr);

   /* this macro adds fileno(stdin) to the file descriptor read_file_descr
*/
   FD_SET(fileno(stdin), &read_file_descr);

   timeout.tv_sec = 0;
   timeout.tv_usec = 100;
   /* int FD_SETSIZE  macro is maximum number of filedescriptors that fd_set
can hold */
   /* function select waits for specified filedescr. to have a signal */
   /* last argument struct timeval *timeout */
   ret = select(1, &read_file_descr, NULL, NULL, &timeout);
   switch( ret ) /* 0 is timeout, -1 error (in errno), 1 = data */
   {
      case -1:
         if( debug_flag )
            fprintf(stdout, "select returned -1 error\n");
         ret = 0;
         break;
      case 0:
         if( debug_flag )
            fprintf(stdout, "select returned 0 timeout\n");
         ret = 0;
         break;
      case 1:
         if( debug_flag )
            fprintf(stdout, "SELECT returned=%d input\n", ret);
         ret = 1;
         break;
      default:
         if( debug_flag )
            fprintf(stdout, "select returned=%d invalid\n", ret);
         break;
   }

   /* test if user has data.  this'll eat the first non-CR keys pressed */
   if( FD_ISSET(fileno(stdin), &read_file_descr) )
   {
      c = getc(stdin);
      if( debug_flag )
         fprintf(stdout, "USER KEY=%d\n", c);
      FD_CLR(fileno(stdin), &read_file_descr);
   }

   return ret;
}

Mark
--
[root@hjinc mclayton] /sbin/insmod stddisclaimer.o


> -----Original Message-----
> From: Steven Vacca [mailto:svacca@valcom.com]
> Sent: Friday, February 15, 2002 10:10 AM
> To: LinuxEmbeddedMailList (E-mail)
> Subject: Unbuffered char reads from App from stdin (keyboard)
>
>
>
> App and Linux kernel 2.2.13 running on mpc860T.
>
> I would like to know the best way, from inside my GNU C App,
> to sense if there's a keyboard key pressed.  Something
> similar to kbhit() in Microsoft C.  I would like to have a particular
> thread execute a loop continuously and only when a key
> is present, do a getc() or getchar(), or gets(), and the like.
>
> What is the best way to accomplish this?
> Is there a way to make stdin unbuffered?
>
> Thanks,
>
> ShutEyeThinkin
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
