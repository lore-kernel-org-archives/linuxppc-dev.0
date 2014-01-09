Return-Path: <sudeep.holla@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by ozlabs.org (Postfix) with ESMTP id 66ACE2C007C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 06:34:58 +1100 (EST)
Message-ID: <52CEF9E7.4070706@arm.com>
Date: Thu, 09 Jan 2014 19:35:03 +0000
From: Sudeep Holla <Sudeep.Holla@arm.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 2/3] ARM: kernel: add support for cpu cache information
References: <1389209168-17189-1-git-send-email-sudeep.holla@arm.com>
 <1389209168-17189-3-git-send-email-sudeep.holla@arm.com>
 <20140108205754.GN27432@n2100.arm.linux.org.uk>
In-Reply-To: <20140108205754.GN27432@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=WINDOWS-1252
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Rob Herring <robh@kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sudeep.Holla@arm.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/01/14 20:57, Russell King - ARM Linux wrote:
> On Wed, Jan 08, 2014 at 07:26:07PM +0000, Sudeep Holla wrote:
>> +#if __LINUX_ARM_ARCH__ < 7 /* pre ARMv7 */
>> +
>> +#define MAX_CACHE_LEVEL=09=091=09/* Only 1 level supported */
>> +#define CTR_CTYPE_SHIFT=09=0924
>> +#define CTR_CTYPE_MASK=09=09(1 << CTR_CTYPE_SHIFT)
>> +
>> +static inline unsigned int get_ctr(void)
>> +{
>> +=09unsigned int ctr;
>> +=09asm volatile ("mrc p15, 0, %0, c0, c0, 1" : "=3Dr" (ctr));
>> +=09return ctr;
>> +}
>> +
>> +static enum cache_type get_cache_type(int level)
>> +{
>> +=09if (level > MAX_CACHE_LEVEL)
>> +=09=09return CACHE_TYPE_NOCACHE;
>> +=09return get_ctr() & CTR_CTYPE_MASK ?
>> +=09=09CACHE_TYPE_SEPARATE : CACHE_TYPE_UNIFIED;
>=20
> So, what do we do for CPUs that don't implement the CTR?  Just return
> random rubbish based on decoding the CPU Identity register as if it
> were the cache type register?
>=20

I assume you referring to some particular CPUs which don't implement this.
I could not find it as optional or IMPLEMENTATION defined in ARM ARM.
I might be missing to find it or there may be exceptions.
Can you please provide more information on that ?

Regards,
Sudeep
