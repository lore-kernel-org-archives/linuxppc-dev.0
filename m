From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Jim Terman <terman@ddi.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: problem with short in va_arg list with 2.95.1 gcc
Date: Sat, 8 Jan 2000 03:27:25 +0100
Content-Type: text/plain
References: <200001072251.OAA13463@sade.ddi.com>
In-Reply-To: <200001072251.OAA13463@sade.ddi.com>
MIME-Version: 1.0
Message-Id: <00010803312300.31253@enzo.bigblue.local>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Am Fre, 07 Jan 2000 schrieb Jim Terman:
>I am having a problem with code that looks for type short in a va_arg list
>when optimization is turned on.  There is no problem with no optimization.
>It compiles fine but produces an undefined reference to `__va_arg_type_violation'
>which I assume is delibrate to flag an error.  Is there a workaround besides
>turning off optimizations?
>
>If I compile the following file:
>test.c
>------
>#include <stdarg.h>
>#include <stdio.h>
>
>void printout(short d, ...)
>{
>  va_list arglist;
>
>  printf("%d ", d);
>  d = va_arg (arglist, short);
>  while (d)
>    {
>      printf("%s ", d);
>      d = va_arg (arglist, short);
>    }
>}
>
>int main()
>{
>  printout(1, 2, 0);
>  printout(2, 3,  4, 0);
>  return 0;
>}

There's no such thing like va_arg(arglist, short) in standard C, you can only
use default promotion types and typedef's thereof. So you have to use (short)
va_arg(arglist, int) here.

Franz.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
