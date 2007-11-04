Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id 16C51DDE41
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 14:29:49 +1100 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1002876rvf
	for <linuxppc-dev@ozlabs.org>; Sat, 03 Nov 2007 20:29:48 -0700 (PDT)
Message-ID: <fa686aa40711032029x3871b76m5b44a6e93d8d7217@mail.gmail.com>
Date: Sat, 3 Nov 2007 21:29:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kumar Gala" <galak@kernel.crashing.org>
Subject: Re: [U-Boot-Users] use of aliases in device trees
In-Reply-To: <DD2A9B2C-5D35-4F53-8542-3470C6FA5265@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <DD2A9B2C-5D35-4F53-8542-3470C6FA5265@kernel.crashing.org>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	U-Boot Users List <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/3/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> In some discussion on the u-boot dev list it became clear that having
> aliases in the device tree might be useful as a common way to deal
> with finding specific nodes that need fixing up by the firmware.
> This problem also exists in the kernel bootwrappers.
>
> The common example is how to associate a given MAC address with the
> proper ethernet node.  In u-boot an explicit path is hard coded into
> the u-boot build for each ethernet device.  In the bootwrapper we use
> "linux,network-index = <N>" in the given ethernet node.
>
> One common solution would be having a top level aliases like the pmac
> tree's have:
>
> aliases {
>         enet0 = "...";
>         enet1 = "...";
>         pci0 = "...";
>         pci1 = "...";
> };

One question to ask is do we use full paths or phandles to point at nodes?

OF, of course, uses full paths, but that does require more memory and
processing power, but it might not be significant enough to worry
about.

If we use phandles, then we should use names that don't conflict with
full path alias names.  It would also be desirable to be able to
generate a phandle alias from the full path alias in order to maintain
some level of compatibility with OF.  It also think it will make
maintaining aliases in .dts files simpler because trivial changes to
node paths won't break the phandle alias.

Maybe something like:
aliases {
      enet0,phandle = <&enet0>;
      enet1,phandle = <&enet1>;
      ...
};

Cheers,
g.

>
> I wanted to see what people think of this idea and about trying to
> use common names for the aliases?  If nothing else I believe we will
> look at doing this on the FSL boards/parts.
>
> - k
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> U-Boot-Users mailing list
> U-Boot-Users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/u-boot-users
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
