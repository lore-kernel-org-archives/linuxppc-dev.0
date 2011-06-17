Return-Path: <lists@gate-nine.de>
Received: from csmtp3.one.com (csmtp3.one.com [91.198.169.23])
	by ozlabs.org (Postfix) with ESMTP id A2F28B6FD8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 23:06:54 +1000 (EST)
Message-ID: <4DFB516C.4060602@gate-nine.de>
Date: Fri, 17 Jun 2011 15:06:52 +0200
From: Philipp Ittershagen <lists@gate-nine.de>
MIME-Version: 1.0
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Changes to of_device ?
References: <201106171119.48178.dargaud@lpsc.in2p3.fr>
	<4DFB329A.7010104@gate-nine.de>
	<201106171322.19067.dargaud@lpsc.in2p3.fr>
	<4DFB4F51.1090509@gate-nine.de>
In-Reply-To: <4DFB4F51.1090509@gate-nine.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/17/2011 02:57 PM, Philipp Ittershagen wrote:
> The struct device_node was moved to struct device in order to make the
> CONFIG_OF more generic. See
> 
> commit d706c1b050274b3bf97d7cb0542c0d070c9ccb8b
> Author: Grant Likely <grant.likely@secretlab.ca>
> Date:   Tue Apr 13 16:12:28 2010 -0700
> 
>     driver-core: Add device node pointer to struct device
> 

I'm sorry, I should have mentioned that struct of_device was replaced by
struct platform_device. So in order to get your code compiled, you have
to change the probe function to

static int xad_driver_probe(struct platform_device* dev, const struct
of_device_id *match) {

The change was introduced by

commit 2dc11581376829303b98eadb2de253bee065a56a
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Fri Aug 6 09:25:50 2010 -0600

    of/device: Replace struct of_device with struct platform_device


Greetings,

  Philipp
