Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4BB6DB6F83
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Apr 2011 08:09:49 +1000 (EST)
Received: by ywh1 with SMTP id 1so2878924ywh.15
	for <linuxppc-dev@ozlabs.org>; Sun, 03 Apr 2011 15:09:46 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1301867559.2549.32.camel@pasglop>
References: <20110401162619.GA20132@crust.elkhashab.com>
	<20110401225903.GA27320@crust.elkhashab.com>
	<1301867559.2549.32.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 3 Apr 2011 16:09:26 -0600
Message-ID: <BANLkTikTeAgc2dg3-M7yM185pg7FAdbAGw@mail.gmail.com>
Subject: Re: problem PCIe LSI detected at 32 device addresses (ppc460ex)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Ayman El-Khashab <ayman@elkhashab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 3, 2011 at 3:52 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
>> Ok, I've narrowed the scope of the problem some. =A0I moved forward
>> to a more recent kernel (2.6.31 to 2.6.36) and that resolved the
>> problem of the controller showing up as every device on the bus.
>> However, from 2.6.37 to the current HEAD, I have not been able to
>> build a kernel to run on the 460EX. =A0I tried 2.6.37, 2.6.38, and
>> the HEAD and all result in the following kernel panic. =A0I am not
>> sure how to proceed here. =A0I suppose we can stick with 2.6.36 since
>> it works, but I'd like to understand what it might take to remedy
>> this.
>
> Smells like somebody changed something with the OF flash code... Josh,
> Grant, any idea what's up there ?

Not sure, more information would be helpful.

Ayman, if you do a 'git log v2.6.36.. drivers/mtd/maps/physmap_of.c',
then you'll see a list of commits touching the mtd driver.  Would you
be able to do a 'git checkout <sha1-id>' on each of those are report
back on at what point things stop working?  Actually, a full bisect
between 2.6.36 and 2.6.37 would be best, but this is a good start if
you're limited on time.  Once you find the first commit where it
fails, do a 'git checkout <sha1>~1' to confirm that it is in fact the
commit that causes the breakage.

Can you also post your device tree please?

Thanks,
g.
