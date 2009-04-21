Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 8DED8DDF39
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 09:45:10 +1000 (EST)
Message-ID: <49EE5A80.4030209@mlbassoc.com>
Date: Tue, 21 Apr 2009 17:45:04 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PCI changes 2.6.26 => 2.6.28
References: <49EDF333.4000200@mlbassoc.com>	<49EE2CD8.7010700@mlbassoc.com>	<29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>	<49EE306D.3000401@mlbassoc.com>	<49EE4729.3000100@mlbassoc.com>	<612CEF05-3EFB-4947-B5FC-B35C1F9568D7@kernel.crashing.org>	<46B035C0-624F-41E4-BFDD-C16479CF8FC8@kernel.crashing.org>	<49EE5021.4020703@mlbassoc.com>
	<306F293D-44CD-4238-ADA9-BB7436C7004C@kernel.crashing.org>
In-Reply-To: <306F293D-44CD-4238-ADA9-BB7436C7004C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Apr 21, 2009, at 6:00 PM, Gary Thomas wrote:
> 
>>
>> I found the difference - in 2.6.28 the inbound/outbound windows
>> don't seem to be set up at all.  In 2.6.26, the function 'fsl_add_bridge'
>> was common among architectures and ended up calling 'setup_pci_atmu'
>> which created those mappings.  In 2.6.28, the 83xx PCI setup code
>> has been refactored.  It uses 'mpc83xx_add_bridge' instead of
>> 'fsl_add_bridge' and 'setup_pci_atmu' is not called at all :-(
>>
>> I'm sure this is the problem.
> 
> Looking at a diff between 2.6.26 and .28 I don't see the 83xx pci code
> calling setup_pci_atmu().

It did not directly; it called 'fsl_add_bridge' which in turn called
'setup_pci_atmu'

I modified the 2.6.28 driver to also call this function.  Now the
inbound/outbound windows are set up, but the bridge still has
no allocations, so the problem remains.

I need to move on; I may just live with sliding the PCI space
up for now (doesn't really hurt anything, just seems like a hack)


-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
