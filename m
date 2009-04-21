Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 235A5DDF39
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 09:41:49 +1000 (EST)
Message-Id: <306F293D-44CD-4238-ADA9-BB7436C7004C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Gary Thomas <gary@mlbassoc.com>
In-Reply-To: <49EE5021.4020703@mlbassoc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: PCI changes 2.6.26 => 2.6.28
Date: Tue, 21 Apr 2009 18:41:43 -0500
References: <49EDF333.4000200@mlbassoc.com>	<49EE2CD8.7010700@mlbassoc.com>	<29EEEBDE-B87C-4073-9967-E1DA7EFB0B0B@kernel.crashing.org>	<49EE306D.3000401@mlbassoc.com>
	<49EE4729.3000100@mlbassoc.com>	<612CEF05-3EFB-4947-B5FC-B35C1F9568D7@kernel.crashing.org>
	<46B035C0-624F-41E4-BFDD-C16479CF8FC8@kernel.crashing.org>
	<49EE5021.4020703@mlbassoc.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 21, 2009, at 6:00 PM, Gary Thomas wrote:

>
> I found the difference - in 2.6.28 the inbound/outbound windows
> don't seem to be set up at all.  In 2.6.26, the function  
> 'fsl_add_bridge'
> was common among architectures and ended up calling 'setup_pci_atmu'
> which created those mappings.  In 2.6.28, the 83xx PCI setup code
> has been refactored.  It uses 'mpc83xx_add_bridge' instead of
> 'fsl_add_bridge' and 'setup_pci_atmu' is not called at all :-(
>
> I'm sure this is the problem.

Looking at a diff between 2.6.26 and .28 I don't see the 83xx pci code  
calling setup_pci_atmu().

- k
