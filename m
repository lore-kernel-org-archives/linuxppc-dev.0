Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3DA4F140155
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Apr 2014 12:51:08 +1000 (EST)
Message-ID: <535B1EB4.3050408@huawei.com>
Date: Sat, 26 Apr 2014 10:49:24 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: David Laight <David.Laight@ACULAB.COM>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 00/13] Refactor pci_is_brdige() to simplify code
References: <1398417515-8740-1-git-send-email-wangyijing@huawei.com>
 <063D6719AE5E284EB5DD2968C1650D6D0F6FEEB0@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D0F6FEEB0@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2014/4/25 17:42, David Laight wrote:
> From: Yijing Wang
>> This patchset rename the current pci_is_bridge() to pci_has_subordinate(),
>> and introduce a new pci_is_bridge() which determine pci bridge by check
>> dev->hdr_type. The new one is more accurate. PCIe Spec define the pci
>> device is a bridge by the dev->hdr_type = 0x01 || 0x02.
> 
> That is a dangerous rename and is likely to cause difficult to

Hi David,
   I renamed pci_is_bridge() to pci_has_subordinate() because

static inline bool pci_is_bridge(struct pci_dev *pci_dev)
{
	return !!(pci_dev->subordinate);
}

which always check dev->subordinate.

> identify bugs in any code you've missed.

What are you referring to ?


Thanks!
Yijing.






> 
> 	David
> 
> �{.n�+�������+%��lzwm��b�맲��r��zX���w��{ay�ʇڙ�,j��f���h���z��w������j:+v���w�j�m��������zZ+�����ݢj"��!�iO��z��v�^�m����nƊ��Y&�
> 


-- 
Thanks!
Yijing
