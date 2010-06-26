Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9B2C2B6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 02:52:50 +1000 (EST)
In-Reply-To: <1277508314-915-12-git-send-email-agraf@suse.de>
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-12-git-send-email-agraf@suse.de>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2078D8A9-7D36-4B5D-A779-9BBAB545A53D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/26] KVM: PPC: Make RMO a define
Date: Sat, 26 Jun 2010 18:52:36 +0200
To: Alexander Graf <agraf@suse.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On PowerPC it's very normal to not support all of the physical RAM  
> in real mode.

Oh?  Are you referring to "real mode limit", or 32-bit  
implementations with
more than 32 address lines, or something else?

Either way, RMO is a really bad name for this, since that name is  
already
used for a similar but different concept.

Also, it seems you construct the physical address by masking out bits  
from
the effective address.  Most implementations will trap or machine  
check if
you address outside of physical address space, instead.


Segher
