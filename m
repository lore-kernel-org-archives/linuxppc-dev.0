In-Reply-To: <19991118211946.B7562@bassano.linuxcare.com>
Date: Fri, 19 Nov 1999 11:02:45 +0100
To: "David N. Welton" <davidw@linuxcare.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: 2.3.28 patch...
Message-Id: <19991119110245.022691@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 18, 1999, David N. Welton <davidw@linuxcare.com> wrote:

>> this patch is basically a sync up from Paul's tree for those trying to get
>> 2.3.28 from linus booting.
>
>My rs6k still doesn't like it.  Hangs somewhere after prom_print, like
>it always does:-/

As I just wrote you privately, you _can_ use prom_print() and
xmon_printf() when booting from Open Firmware but only if you have the
appropriate patch. You can find the code for that in the prom.c patch
inside the ibook patches on my page.

Also make sure to fix xmon so that it initialises correctly for on-screen
display (it does this by default on PowerBooks only for now). If you
don't use xmon, then manually call map_bootx_text() just after the MMU
init, or manually map the fb with a BAT inside MMU init.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
