From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: mesh in 2.4.0-test1
Date: Thu, 31 Dec 1903 23:50:06 +0100
Message-Id: <19031231225006.29288@192.168.1.10>
In-Reply-To: <Pine.LNX.4.05.10006041259560.514-100000@callisto.of.borg>
References: <Pine.LNX.4.05.10006041259560.514-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jun 4, 2000, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>After 3 days of hacking, I found it. The new Core99 interrupt tree code
>doesn't
>take into account that on CHRP boxes with both ISA and OpenPIC, the interrupt
>numbers have to be fixed up. Below is the patch that made it work for me.
>
>Before I check it in into bitkeeper: should I replace the test
>
>    _machine == _MACH_chrp
>
>by
>
>    !strncmp(model, "IBM,LongTrail", 13)
>
>or are there other CHRP models bitten by this as well?

After reading the code more closely, it appear that I spoke to quickly:
_machine is initialized before finish_device_tree() in all cases. I
beleive this problem will happen with all CHRPs since all of them have an
ISA legacy controller. So I'll keep the test
as it is, and I'll merge the fix into bk today for both 2.2 and 2.4 along
with some other prom.c changes I have here.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
