From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        ian reinhart geiser <geiseri@msoe.edu>
Subject: Re: Problems Compileing PVM
Date: Sun, 7 May 2000 14:28:09 -0400
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <Pine.LNX.4.10.10005071634240.5834-100000@opal.biophys.uni-duesseldorf.de>
In-Reply-To: <Pine.LNX.4.10.10005071634240.5834-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Message-Id: <00050714365900.05361@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Sun, 07 May 2000, Michael Schmitz wrote:
> > __va_arg_type_violation

Franz once explained this error to me.  It seems according to the ANSI C
standard va_arg can only be done with primary (promoted) types like integer,
double, etc.  For any other type, a cast must be done to create proper ansi c.

gcc is going to barf on this on all platforms in the future, but right now it
does so only under optimization on ppc.

The solution is just to edit and code and make the correction(s).

 Here are some code snippets to illustrate:

va_arg(args,boolean) 	becomes 	(boolean)va_arg(args, int)

va_arg(args,byte) 	becomes 	(byte)va_arg(args, int)

va_arg(args,char)	becomes		(char)va_arg(args, int)

va_arg(ags,short)	becomes		(short)va_arg(args, int)

va_arg(args,int)  is okay since it is a primary (promoted) type

va_arg(args, long long) is okay since long long is a primary (promoted) type

va_arg(args,float)	becomes		(float)va_arg(args, double)

va_arg(args,double) is okay since it is a primary (promoted) type

I hope this helps.

Kevin


On Sun, 07 May 2000, Michael Schmitz wrote:
> > __va_arg_type_violation
> >
> > 	It looks like a linker error...
>
> No, it rather is a varargs usage error (illegal types used in va_arg()
> calls). Sloppy programming is the cause of this, most likely.

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
