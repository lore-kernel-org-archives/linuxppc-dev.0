Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E408167B83
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 04:50:25 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k85IoM8K027623
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 14:50:22 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k85IoMAS221856
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 12:50:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k85IoL9a012176
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Sep 2006 12:50:21 -0600
Date: Tue, 5 Sep 2006 13:50:20 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pci error recovery procedure
Message-ID: <20060905185020.GD7139@austin.ibm.com>
References: <1157008212.20092.36.camel@ymzhang-perf.sh.intel.com>
	<20060831175001.GE8704@austin.ibm.com>
	<1157081629.20092.167.camel@ymzhang-perf.sh.intel.com>
	<20060901212548.GS8704@austin.ibm.com>
	<1157348850.20092.304.camel@ymzhang-perf.sh.intel.com>
	<1157360592.22705.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1157360592.22705.46.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
	Yanmin Zhang <yanmin.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>,
	Rajesh Shah <rajesh.shah@intel.com>, linuxppc-dev@ozlabs.org,
	linux-pci maillist <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 04, 2006 at 07:03:12PM +1000, Benjamin Herrenschmidt wrote:
> 
> > As you know, all functions of a device share the same bus number and 5 bit dev number.
> > They just have different 3 bit function number. We could deduce if functions are in the same
> > device (slot).
> 
> Until you have a P2P bridge ...

And this is not theoretical: for example, the matrox graphics cards:

0000:c8:01.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 13)
0000:c9:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 85)

Now, I could have sworn there was another device behind this bridge, 
some serial or joystick controller or something, although this
particular card doesn't seem to have it.

------
It's not clear to me what hardware may show up in the future. 
For example, someone may build a 32x PCI-E card that will act 
as a bridge to a drawer with half-a-dozen ordinary PCI-X slots 
in it. This is perhaps a bit hypothetical, but changing the API 
will make it harder to implement eror recovery for such a system.

FWIW, there is at least one pSeries system in the lab which has
several hundred PCI slots attached to it, although I've never 
done testing on it. Hmm. Maybe its time I did ... 

--linas
