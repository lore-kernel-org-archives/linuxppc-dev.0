Date: Fri, 16 Feb 2001 14:01:55 -0600 (CST)
From: Grant Erickson <erick205@umn.edu>
To: linuxppc-embedded@lists.linuxppc.org
Cc: Miquel van Smoorenburg <miquels@cistron.nl>
Subject: SysVInit, /etc/TIMEZONE, getty_ps, telnet, and rsh
Message-Id: <Pine.SOL.4.20.0102161326460.11498-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In an attempt to eliminate the overhead of '/usr/share/zoneinfo' from
glibc in an embedded system, I have attempted to modify sysvinit, via the
patch below, to read "/etc/default/init" (aka /etc/TIMEZONE) much like
other UNIX (e.g. Irix, Solaris) init processes do.

The problem I am having, which may be due to inappropriate hacking of
sysvinit, is that sometimes processes of which 'init' is a parent do not
inherit the environment variables exported:

>From the console (getty_ps):

	root@walnut# date
	Fri Feb 16 19:46:24 /etc/localtime 2001

	root@walnut# ps -ef
	root        17     1  0 18:52 ?        00:00:00 -sh

>From telnet (0.17):

	root@walnut# date
	Fri Feb 16 19:48:57 UTC 2001

	root@walnut# ps -ef
	root       145     1  0 18:52 ?        00:00:00 /usr/sbin/inetd
	root       223   145  0 19:48 ?        00:00:00 in.telnetd: stcroix
	root       224   223  0 19:48 pts/0    00:00:00 -sh

>From rsh (0.17):

	root@walnut# date
	Fri Feb 16 19:57:06 /etc/localtime 2001

	root@walnut# ps -ef
	root       145     1  0 18:52 ?        00:00:00 /usr/sbin/inetd
	root       239   145  0 19:56 ?        00:00:00 in.rlogind
	root       240   239  0 19:56 pts/0    00:00:00 -sh

>From ssh (2.3.0p1):

	root@walnut# date
	Fri Feb 16 19:58:19 UTC 2001

	root@walnut# ps -ef
	root       145     1  0 18:52 ?        00:00:00 /usr/sbin/inetd
	root       254   145  4 19:58 ?        00:00:00 sshd -i -b 512
	root       255   254  1 19:58 pts/0    00:00:00 -sh

The file /etc/default/init:

	#     Lines of this file should be of the form VAR=value, where
	#     VAR is one of the variables above.
	TZ=UTC

For some odd reason, 'telnetd' and 'getty_ps' logins don't pick up the
variable "TZ".

Has anyone else modified sysvinit in this way? Any success? Did I miss
something key in my patch?

Any insight would be greatly appreciated.

Regards,

Grant


--- sysvinit/src/init.c 2000/11/08 01:07:33
+++ sysvinit/src/init.c 2001/01/13 02:45:33
@@ -1075,6 +1075,70 @@
 }

 /*
+ * Check if a given environment string sets variables initialized by
+ * sysvinit.
+ */
+static int isenv_var(const char *string)
+{
+       register char **v;
+       static char *vars[] = {
+               "LANG", "LC_COLLATE", "LC_CTYPE", "LC_MESSAGES",
+               "LC_MONETARY", "LC_NUMERIC", "LC_TIME", "TZ", NULL
+       };
+
+       for (v = vars; *v != NULL; v++) {
+               if (strncmp(*v, string, strlen(*v)) == 0)
+                       return (1);
+       }
+
+       return (0);
+}
+
+/*
+ *     Read the TIMEZONE file.
+ */
+static void read_timezone(void)
+{
+       FILE *fp;
+       char *p, buf[256];
+
+#if DEBUG
+       log(L_VB, "Reading " TIMEZONE);
+#endif
+
+       /* Open TIMEZONE and read line-by-line */
+
+       if ((fp = fopen(TIMEZONE, "r")) == NULL)
+               return;
+
+       while(fgets(buf, sizeof (buf), fp) != NULL) {
+
+               /* Ignore blank lines and comments */
+
+               if ((buf[0] == '#') || (buf[0] == '\n'))
+                       continue;
+
+               /*
+                * Ignore things that don't look like environment strings or
+                * variables we care about.
+                */
+
+               if (strchr(buf, '=') == NULL || !isenv_var(buf))
+                       continue;
+
+               /* Chomp the new line */
+
+               if ((p = strchr(buf, '\n')) != NULL) {
+                       *p = '\0';
+               }
+
+               putenv(strdup(buf));
+       }
+
+       fclose(fp);
+}
+
+/*
  *     Read the inittab file.
  */
 void read_inittab(void)
@@ -2357,6 +2421,8 @@
         */
        log(L_CO, bootmsg, "booting");

+       read_timezone();
+
        /*
         *      See if we have to start an emergency shell.
         */


--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
