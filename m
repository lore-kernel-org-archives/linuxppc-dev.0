Return-Path: <panto@intracom.gr>
Message-ID: <417F39EB.5010907@intracom.gr>
Date: Wed, 27 Oct 2004 09:02:19 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DB95@ismail.innsys.innovsys.com>
	<20041026143514.GQ25154@smtp.west.cox.net>
In-Reply-To: <20041026143514.GQ25154@smtp.west.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 uart early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

>On Fri, Oct 22, 2004 at 05:01:54PM -0500, Rune Torgersen wrote:
>
>>>From: Tom Rini [mailto:trini@kernel.crashing.org] 
>>>On Thu, Oct 21, 2004 at 04:57:56PM -0500, Rune Torgersen wrote:
>>>
>>>>BTW..
>>>>What are the device node numbers for ttyCPM[0..5] ?
>>>>
>>>204 42...45 (devices.txt in linuxppc-2.5, Pantelis ever 
>>>figure out what to do about the device # conflict with the 
>>>i.MX driver so we can push that small bit upstream ?)
>>>
>>Aparently not that simple.... I looked in the source, and it depends if 
>>an 8250 stype serial port is defined or not...
>>
>>#ifndef CONFIG_SERIAL_8250
>>#define SERIAL_CPM_MAJOR	TTY_MAJOR
>>#define SERIAL_CPM_MINOR	64
>>#else
>>#define SERIAL_CPM_MAJOR	204
>>#define SERIAL_CPM_MINOR	42
>>#endif
>>
>>Urgh...
>>
>
>That doesn't make sense.  Pantelis?
>
>
Well, it sure doesn't.

We should really try to find a generic solution to this
problem, i.e. that SoC like processors almost always have a number of serial
ports, and every single one ends up being of a different major/minor number.

IMHO the best solution would be to allocate a single major number, and
then map to the minors in order, the possible serial ports.

We could do this easily for PPC at first, and try to pursuade the other
embedded people to convert. The old device names can always be supported
via simple symbolic links.

For example let's take the 8xx family.

It is possible to have a maximum of 6 on chip serial ports; SCC1-4 + SMC1-2.

The devices could be

crw-------  1 root root 0, 64 Mar 24  2004 ttyC0 # SCC1
crw-------  1 root root 1, 64 Mar 24  2004 ttyC1 # SCC2
crw-------  1 root root 2, 64 Mar 24  2004 ttyC2 # SCC3
crw-------  1 root root 3, 64 Mar 24  2004 ttyC3 # SCC4
crw-------  1 root root 4, 64 Mar 24  2004 ttyC4 # SMC1
crw-------  1 root root 5, 64 Mar 24  2004 ttyC5 # SMC2

The compatibility link for a single SMC1 console.

lrwxrwxrwx  1 root root        5 Oct 25 16:56 ttyS0 -> ttyC4

In a similar manner we could do the same to 82xx, and every other
SoC in existance.

So what do you think?

Regards

Pantelis
