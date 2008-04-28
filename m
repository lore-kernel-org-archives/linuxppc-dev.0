Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 85036DDED3
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 06:49:28 +1000 (EST)
Date: Mon, 28 Apr 2008 13:49:06 -0700
From: Greg KH <gregkh@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: 2.6.25-git12 sysfs panic
Message-ID: <20080428204906.GA10811@suse.de>
References: <1209414970.23575.17.camel@badari-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1209414970.23575.17.camel@badari-desktop>
Cc: linuxppc-dev@ozlabs.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 28, 2008 at 01:36:10PM -0700, Badari Pulavarty wrote:
> Hi Greg,
> 
> Ran into this sysfs oops while booting 2.6.25-git12.

It's not an "oops" but a WARN_ON(1);

> ipr issue ?

Stupid driver issue, yes:

> ipr: IBM Power RAID SCSI Device Driver version: 2.4.1 (April 24, 2007)
> ipr 0000:d0:01.0: Found IOA with IRQ: 119
> ipr 0000:d0:01.0: Starting IOA initialization sequence.
> ipr 0000:d0:01.0: Adapter firmware version: 020A005E
> ipr 0000:d0:01.0: IOA initialized.
> scsi0 : IBM 570B Storage Adapter
> sysfs: duplicate filename 'state' can not be created

Looks like someone messed up, not the sysfs core's fault here :)

thanks,

greg k-h
