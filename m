Date: Tue, 21 Mar 2000 00:12:37 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Rhys <rhiannon@miranda.inetsolve.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: limited range of data error
In-Reply-To: <200003202228.RAA22962@miranda.inetsolve.com>
Message-ID: <Pine.HPX.4.10.10003202359180.28648-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 20 Mar 100, Rhys wrote:

>
> When i try to compile i get these errors:
>
> act_comm.c: In function 'send_ascii_title':
> act_comm.c:2234: warning: comparison is always true due to
> limited range of data type

Classical problem: don't assign the return value of fgetc to a char before
checking for EOF.

By definition, fgetc returns an unsigned char cast to an int or eof. On
machines on which char is signed by default, this seems to work in most
cases, except that one day char \0xff will be taken for eof. And yes there
are charsets in which \0xff may be used. Just feed a normal text file in
which you have a Latin-1 lowercase y with diaeresis, and watch for bugs in
most text processing programs.

Using the compiler option -fsigned-char only hides the problem. It does
not solve it. Actually, because of this convention, nothing should ever be
compiled with -fsigned-char and you should use -funsigned-char on _all_
platforms since it implicitly checks for some stupid bugs like this one,
thereby showing the intrinsic superiority of unsigned chars.


> This is from a redhat system. I think there are
> problems with me missing the files related to
> fgetc() and fopen(). Anyone have any ideas for
> how to get this to work?
>
> Relevent code is:
>

Oh, BTW, this code is not very well protected against buffer overflows, to
put it mildly. But I leave it up to you.

	Gabriel.

(hand built unified diff, no line numbers or other cruft)
  send_ascii_title( CHAR_DATA *ch )
  {
     FILE *rpfile;
-    int num=0;
+    int num=0, tmp;

     char BUFF[MAX_STRING_LENGTH];

     if ((rpfile = fopen(ASCTITTLE_FILE, "r")) !=NULL) {
-      while (( BUFF[num]=fgetc(rpfile)) != OEF) // Line 2234
-         num++;
+      while (( tmp=fgetc(rpfile)) != EOF) // Line 2234
+	 BUFF[num++] = tmp;
       fclose(rpfile);
     BUFF[num] = 0;
     write_to_buffer( ch->desc, BUFF, num );
     }
  }



>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
