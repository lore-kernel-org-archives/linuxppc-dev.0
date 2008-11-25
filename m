Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 13821474C1
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 06:31:37 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so67494yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 11:31:36 -0800 (PST)
Message-ID: <b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com>
Date: Tue, 25 Nov 2008 13:31:35 -0600
From: "Matt Sealey" <matt@genesi-usa.com>
To: "Grant Erickson" <gerickson@nuovations.com>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
In-Reply-To: <C5518C2F.13137%gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_10359_27567877.1227641495569"
References: <20081125135519.038abf23@zod.rchland.ibm.com>
	<C5518C2F.13137%gerickson@nuovations.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Wolfgang Denx <wd@denx.de>, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_10359_27567877.1227641495569
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Actually there is an ARM board out there with an Open Firmware (Toshiba
TOPAS910 -
http://www.toshiba-components.com/microcontroller/BMSKTOPAS910.html) so,
yes, device trees do appear on those platforms. QEMU is looking to go that
way too, seems for every architecture it would be a pretty awesome idea
(especially on ARM).

In any case, for platforms that don't, you can then make sure the "depends
on" line in Kconfig is for boards with no device trees - right now that
particular thing escapes me but I bet !PPC_OF or similar couldn't be too far
from the truth - so the ability to set the values is taken away if you have
device tree support built-in.

On MIPS or ARM with no DT support, if they don't have device tree support
compiled in, the options magically appear. You get the best of both worlds.

There is also no reason you can't hard-code the locations into the device
tree, to support older U-Boots that don't know about
/chosen/linux,log-metadata and /chosen/linux,log-buffer*.

I can think of a bunch of reasons why it's a good idea.. what if your board
supports a DIMM and you want to keep the buffer up near the top of memory,
or the MBAR/CCSRBAR/IMMRBAR or whatever can move location so your SRAM moves
around depending on your firmware version or feature support, or, similarly,
if your L2 and SRAM are the same thing and can be configured to use
different sizes on each boot - pick a different size for the L2/SRAM and the
location may have to be moved, which means compiling a new firmware AND a
new kernel and matching up the values.. in the end it makes everyone's life
easier.

* naive implementation - if you only specify log-buffer then that means
metadata and buffer are "colocated" as your docs said, that'd be the least
complicated way to implement it without involving a hell of a lot of new
stuff, plus it means you can check the existance/value of two properties in
a node you can guarantee exists. Also since the log buffer format is
Linux-specific and Linux-compatible, and entirely a Linux feature, just like
the linux,initrd-start and -end, making a whole new node seems wasteful.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

On Tue, Nov 25, 2008 at 1:04 PM, Grant Erickson <gerickson@nuovations.com>wrote:

> On 11/25/08 10:55 AM, Josh Boyer wrote:
> > On Tue, 25 Nov 2008 12:53:12 -0600
> > "Matt Sealey" <matt@genesi-usa.com> wrote:
> >> Nitpick, really.. shouldn't the logbuffer location(s) be some device
> tree
> >> property(ies), perhaps something in the
> >> /chosen node that U-Boot etc. can then fill out?
> >
> > I don't think that's a nitpick.  It's a fundamental change in how this
> > would all work.  However, I do think you're generally right.
> >
> > Perhaps not /chosen, but maybe something like /rtas or /firmware, etc.
>
> I'm inclined to agree with you both; however, the submitted implementation
> was a choice of expediency given the existing DENX implementation and a
> customer that needed the feature "yesterday".
>
> ARM, MIPS, et al have not yet adopted device trees, correct? If so, is
> there
> value in providing the submitted implementation and adding support for
> getting said information from the device tree as another option if such
> information exists?
>
> Regards,
>
> Grant
>
>
>

------=_Part_10359_27567877.1227641495569
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Actually there is an ARM board out there with an Open Firmware (Toshiba
TOPAS910 -
<a href="http://www.toshiba-components.com/microcontroller/BMSKTOPAS910.html">http://www.toshiba-components.com/microcontroller/BMSKTOPAS910.html</a>)
so, yes, device trees do appear on those platforms. QEMU is looking to
go that way too, seems for every architecture it would be a pretty
awesome idea (especially on ARM).<br><br>In any case, for platforms that don&#39;t, you can then make sure the &quot;depends on&quot; line in Kconfig is for boards with no device trees - right now that particular thing escapes me but I bet !PPC_OF or similar couldn&#39;t be too far from the truth - so the ability to set the values is taken away if you have device tree support built-in.<br>
<br>On MIPS or ARM with no DT support, if they don&#39;t have device tree support compiled in, the options magically appear. You get the best of both worlds.<br><br>There is also no reason you can&#39;t hard-code the locations into the device tree, to support older U-Boots that don&#39;t know about /chosen/linux,log-metadata and /chosen/linux,log-buffer*.<br>
<br>I can think of a bunch of reasons why it&#39;s a good idea.. what if your board supports a DIMM and you want to keep the buffer up near the top of memory, or the MBAR/CCSRBAR/IMMRBAR or whatever can move location so your SRAM moves around depending on your firmware version or feature support, or, similarly, if your L2 and SRAM are the same thing and can be configured to use different sizes on each boot - pick a different size for the L2/SRAM and the location may have to be moved, which means compiling a new firmware AND a new kernel and matching up the values.. in the end it makes everyone&#39;s life easier.<br>
<br>* naive implementation - if you only specify log-buffer then that means
metadata and buffer are
&quot;colocated&quot; as your docs said, that&#39;d be the least complicated way to
implement it without involving a hell of a lot of new stuff, plus it
means you can check the existance/value of two properties in a node you
can guarantee exists. Also since the log buffer format is Linux-specific and Linux-compatible, and entirely a Linux feature, just like the linux,initrd-start and -end, making a whole new node seems wasteful.<br><br>-- <br>
Matt Sealey &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt;<br>Genesi, Manager, Developer Relations<br><br><div class="gmail_quote">On Tue, Nov 25, 2008 at 1:04 PM, Grant Erickson <span dir="ltr">&lt;<a href="mailto:gerickson@nuovations.com">gerickson@nuovations.com</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><div class="Wj3C7c">On 11/25/08 10:55 AM, Josh Boyer wrote:<br>
&gt; On Tue, 25 Nov 2008 12:53:12 -0600<br>
&gt; &quot;Matt Sealey&quot; &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt; wrote:<br>
&gt;&gt; Nitpick, really.. shouldn&#39;t the logbuffer location(s) be some device tree<br>
&gt;&gt; property(ies), perhaps something in the<br>
&gt;&gt; /chosen node that U-Boot etc. can then fill out?<br>
&gt;<br>
&gt; I don&#39;t think that&#39;s a nitpick. &nbsp;It&#39;s a fundamental change in how this<br>
&gt; would all work. &nbsp;However, I do think you&#39;re generally right.<br>
&gt;<br>
&gt; Perhaps not /chosen, but maybe something like /rtas or /firmware, etc.<br>
<br>
</div></div>I&#39;m inclined to agree with you both; however, the submitted implementation<br>
was a choice of expediency given the existing DENX implementation and a<br>
customer that needed the feature &quot;yesterday&quot;.<br>
<br>
ARM, MIPS, et al have not yet adopted device trees, correct? If so, is there<br>
value in providing the submitted implementation and adding support for<br>
getting said information from the device tree as another option if such<br>
information exists?<br>
<br>
Regards,<br>
<font color="#888888"><br>
Grant<br>
<br>
<br>
</font></blockquote></div><br><br clear="all"><br>

------=_Part_10359_27567877.1227641495569--
