Return-Path: <joro@8bytes.org>
Received: from 8bytes.org (8bytes.org [88.198.83.132])
	by ozlabs.org (Postfix) with ESMTP id 32B19B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Aug 2011 23:56:36 +1000 (EST)
Date: Sun, 28 Aug 2011 15:56:33 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Avi Kivity <avi@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110828135632.GG8978@8bytes.org>
References: <1314040622.6866.268.camel@x201.home>
	<20110823131441.GN2079@amd.com>
	<1314119311.2859.59.camel@bling.home>
	<20110824085213.GB2079@amd.com>
	<1314198467.2859.192.camel@bling.home>
	<20110825123146.GD1923@amd.com>
	<EC0C2298-1EC9-42A0-9A71-3671E21BCA56@suse.de>
	<20110826042423.GF2308@yookeroo.fritz.box>
	<20110826092440.GO1923@amd.com> <4E5A3F18.7050903@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E5A3F18.7050903@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Alexey Kardashevskiy <aik@au1.ibm.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Paul Mackerras <pmac@au1.ibm.com>, "Roedel, Joerg" <Joerg.Roedel@amd.com>,
	qemu-devel <qemu-devel@nongnu.org>,
	Alexander Graf <agraf@suse.de>, chrisw <chrisw@sous-sol.org>,
	iommu <iommu@lists.linux-foundation.org>,
	Anthony Liguori <anthony@codemonkey.ws>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"benve@cisco.com" <benve@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 28, 2011 at 04:14:00PM +0300, Avi Kivity wrote:
> On 08/26/2011 12:24 PM, Roedel, Joerg wrote:

>> The biggest problem with this approach is that it has to happen in the
>> context of the given process. Linux can't really modify an mm which
>> which belong to another context in a safe way.
>>
>
> Is use_mm() insufficient?

Yes, it introduces a set of race conditions when a process that already
has an mm wants to take over another processes mm temporarily (and when
use_mm is modified to actually provide this functionality). It is only
save when used from kernel-thread context.

One example:

	Process A		Process B			Process C
	.			.				.
	.		<--	takes A->mm			.
	.			and assignes as B->mm		.
	.			.			-->	Wants to take
	.			.				B->mm, but gets
								A->mm now

This can't be secured by a lock, because it introduces potential
A->B<-->B->A lock problem when two processes try to take each others mm.
It could probably be solved by a task->real_mm pointer, havn't thought
about this yet...

	Joerg
