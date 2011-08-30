Return-Path: <joro@8bytes.org>
Received: from 8bytes.org (8bytes.org [88.198.83.132])
	by ozlabs.org (Postfix) with ESMTP id 5558CB6F92
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 31 Aug 2011 02:14:35 +1000 (EST)
Date: Tue, 30 Aug 2011 18:14:33 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Avi Kivity <avi@redhat.com>
Subject: Re: kvm PCI assignment & VFIO ramblings
Message-ID: <20110830161433.GC5203@8bytes.org>
References: <1314119311.2859.59.camel@bling.home>
	<20110824085213.GB2079@amd.com>
	<1314198467.2859.192.camel@bling.home>
	<20110825123146.GD1923@amd.com>
	<EC0C2298-1EC9-42A0-9A71-3671E21BCA56@suse.de>
	<20110826042423.GF2308@yookeroo.fritz.box>
	<20110826092440.GO1923@amd.com> <4E5A3F18.7050903@redhat.com>
	<20110828135632.GG8978@8bytes.org> <4E5A4AF0.20707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E5A4AF0.20707@redhat.com>
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

On Sun, Aug 28, 2011 at 05:04:32PM +0300, Avi Kivity wrote:
> On 08/28/2011 04:56 PM, Joerg Roedel wrote:

>> This can't be secured by a lock, because it introduces potential
>> A->B<-->B->A lock problem when two processes try to take each others mm.
>> It could probably be solved by a task->real_mm pointer, havn't thought
>> about this yet...
>>
>
> Or a workqueue -  you get a kernel thread context with a bit of boilerplate.

Right, a workqueue might do the trick. We'll evaluate that. Thanks for
the idea :)

	Joerg
