From: Rhys <rhiannon@miranda.inetsolve.com>
Message-Id: <200003202228.RAA22962@miranda.inetsolve.com>
Subject: limited range of data error
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 20 Mar 100 17:28:06 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When i try to compile i get these errors:

act_comm.c: In function 'send_ascii_title':
act_comm.c:2234: warning: comparison is always true due to
limited range of data type

This is from a redhat system. I think there are
problems with me missing the files related to
fgetc() and fopen(). Anyone have any ideas for
how to get this to work?

Relevent code is:

send_ascii_title( CHAR_DATA *ch )
{
   FILE *rpfile;
   int num=0;
   char BUFF[MAX_STRING_LENGTH];

   if ((rpfile = fopen(ASCTITTLE_FILE, "r")) !=NULL) {
     while (( BUFF[num]=fgetc(rpfile)) != OEF) // Line 2234
        num++;
     fclose(rpfile);
   BUFF[num] = 0;
   write_to_buffer( ch->desc, BUFF, num );
   }
}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
