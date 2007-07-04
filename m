Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18059.5083.741194.497123@cargo.ozlabs.ibm.com>
Date: Wed, 4 Jul 2007 13:28:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Should of_device_is_compatible() use strcmp() rather than
	strncasecmp()?
In-Reply-To: <468ABF4A.60001@freescale.com>
References: <468ABF4A.60001@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> Is there any particular reason that of_device_is_compatible uses 
> strncasecmp()?  Besides the OF spec saying that names (and thus 
> compatibles) are case sensitive, the "n" part screws up matching when a 
> subset of a string is not a more generic version thereof.  For example, 
> ucc_geth v. ucc_geth_phy, or fsl,cpm v. fsl,cpm-enet.
> 
> Does anything actually rely on this behavior?

Things did in the past rely on the case-insensitive comparison but
probably don't any more.  I recall an issue with "ata" vs. "ATA" on
the powerbook 3400.

As for the "n" part, I don't recall exactly why that was done.  I
think we should change it to use strcmp and fix any drivers that
break.

Paul.
