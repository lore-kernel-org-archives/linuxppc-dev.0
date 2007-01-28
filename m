Return-Path: <ebiederm@xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 495ABDE42B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 09:19:44 +1100 (EST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/6] msi: Kill msi_lookup_irq
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1hcubq6re.fsf@ebiederm.dsl.xmission.com>
	<m1d54zq6o3.fsf_-_@ebiederm.dsl.xmission.com>
	<17853.7463.911235.324340@cargo.ozlabs.ibm.com>
Date: Sun, 28 Jan 2007 15:18:55 -0700
In-Reply-To: <17853.7463.911235.324340@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Mon, 29 Jan 2007 09:01:11 +1100")
Message-ID: <m1slduokvk.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tony Luck <tony.luck@intel.com>, Grant Grundler <grundler@parisc-linux.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	Ingo Molnar <mingo@elte.hu>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> Eric W. Biederman writes:
>
>> @@ -693,15 +664,14 @@ int pci_enable_msi(struct pci_dev* dev)
>>  	if (!pos)
>>  		return -EINVAL;
>>  
>> -	WARN_ON(!msi_lookup_irq(dev, PCI_CAP_ID_MSI));
>> +	WARN_ON(!!dev->msi_enabled);
>
> Minor nit: what's wrong with just WARN_ON(dev->msi_enabled) ?

It's a bitfield so gcc complains when something in WARN_ON calls
typeof on it.  So it is easier to just say !! than to dig into
WARN_ON and see if it made any sense to fix WARN_ON, or to see if gcc
needed the bug fix.

> Also here:
>
>> @@ -836,16 +811,14 @@ int pci_enable_msix(struct pci_dev* dev, struct
> msix_entry *entries, int nvec)
>>  				return -EINVAL;	/* duplicate entry */
>>  		}
>>  	}
>> -	temp = dev->irq;
>> -	WARN_ON(!msi_lookup_irq(dev, PCI_CAP_ID_MSIX));
>> +	WARN_ON(!!dev->msix_enabled);
>
> Paul.
