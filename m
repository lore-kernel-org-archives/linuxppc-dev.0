Return-Path: <htejun@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0FE0FB6FA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 17:51:22 +1000 (EST)
Received: by fxm5 with SMTP id 5so150577fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jun 2011 00:51:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 16 Jun 2011 09:51:14 +0200
From: Tejun Heo <tj@kernel.org>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: libata/ipr/powerpc: regression between 2.6.39-rc4 and 2.6.39-rc5
Message-ID: <20110616075114.GH8141@htj.dyndns.org>
References: <20110615191747.GA6324@us.ibm.com>
	<4DF90FCA.1040706@linux.vnet.ibm.com>
	<20110615233417.GB6324@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110615233417.GB6324@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, wayneb@linux.vnet.ibm.com,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Brian King <brking@linux.vnet.ibm.com>, mbizon@freebox.fr,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 15, 2011 at 04:34:17PM -0700, Nishanth Aravamudan wrote:
> > That looks like the right thing to do. For ipr's usage of
> > libata, we don't have the concept of a port frozen state, so this flag
> > should really never get set. The alternate way to fix this would be to
> > only set ATA_PFLAG_FROZEN in ata_port_alloc if ap->ops->error_handler
> > is not NULL.
> 
> It seemed like ipr is as you say, but I wasn't sure if it was
> appropriate to make the change above in the common libata-scis code or
> not. I don't want to break some other device on accident.
> 
> Also, I tried your suggestion, but I don't think that can happen in
> ata_port_alloc? ata_port_alloc is allocated ap itself, and it seems like
> ap->ops typically gets set only after ata_port_alloc returns?

Maybe we can test error_handler in ata_sas_port_start()?

Thanks.

-- 
tejun
