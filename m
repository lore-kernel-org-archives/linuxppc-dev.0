Date: Tue, 26 Oct 1999 19:03:25 -0400
From: Bob Toxen <bob@roger.realminfo.com>
Message-Id: <199910262303.TAA26743@roger.realminfo.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Nested stdarg broken?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


My application uses stdarg (#include <stdarg.h>, va_start, and friends)
in a function that then calls vfprintf which also uses stdarg.

The variable args get garbled by the time they get to vfprintf.  The
fmt arg does not get garbled.

Note that the documentation specifies that this should work.  My application
works fine on Linux on Intel and other platforms.  The PowerPC is the first
big endian platform but I am quite sure that the bug is not in my code.

My code (simplified) looks like

#include <stdio.h>
#include <stdarg.h>

logmsg(int out, const char *fmt, ...)
{
	FILE	*fp;
	char	*p;
	int	ret	= 0;
	char	buf[512];
	va_list	ap;	/* May need to be last arg. */

	va_start(ap, fmt);
	fflush(stdout);		/* Flush "the other" output. */
	fp = fopen(logfile, "a");
	if (!fp || vfprintf(fp, fmt, ap) < 1)
		ret = -1;
	if (fp && fclose(fp) == EOF)
		ret = -1;
	va_end(ap);
	return ret;
}

THANKS for any insight.  Presently I'm IFDEFing it to not use stdargs on
the PowerPC platform.

Bob Toxen
bob@roger.realminfo.com
Error #152, Windows not found: (C)heer, (P)arty, (D)ance

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
