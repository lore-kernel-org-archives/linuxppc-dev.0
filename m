Message-Id: <4.2.0.58.19990909192900.00af6450@mail.lauterbach.com>
Date: Thu, 09 Sep 1999 19:35:41 +0200
To: Maurice DIAMANTINI <diam@pmdiam.ensta.fr>
From: Franz Sirl <Franz.Sirl@munich.netsurf.de>
Subject: Re: bug glibc strlen() or tcl8.2
Cc: linuxppc-dev@lists.linuxppc.org, Maurice DIAMANTINI <diam@pmdiam.ensta.fr>
In-Reply-To: <19990909164200.A17615@pmdiam.ensta.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 16:42 09.09.99 , Maurice DIAMANTINI wrote:

>Hello
>
>I'm unable to execute tcl8.2 on linuxppc R5. Although it compile and
>run very simply on intel box, solaris, ... but not on linuxppc
>
>
>The programm compils OK, but get a core dump at the first execution
>of a tcl command (in fact at the "make test")

[...]

>     memcpy ((VOID *) &tmpArgList, (VOID *) &argList, sizeof (tmpArgList));
      ^^^^^^^^

This is unportable in combination with va_list. Try:

       __va_copy (tmpArgList, argList);

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
