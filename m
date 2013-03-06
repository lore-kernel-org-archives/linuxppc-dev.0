Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48E032C0378
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 16:35:15 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Wed, 6 Mar 2013 11:02:16 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id BFC52125804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 11:06:03 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r265Z1QT27459786
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 11:05:02 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r265Z4g3019622
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Mar 2013 16:35:05 +1100
Message-ID: <5136D582.80101@linux.vnet.ibm.com>
Date: Wed, 06 Mar 2013 13:34:58 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] irq: Add hw continuous IRQs map to virtual continuous
 IRQs support
References: <1358235536-32741-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <1358235536-32741-3-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20130305022348.GB7656@concordia> <51359C9D.5030009@linux.vnet.ibm.com>
 <20130306035443.GB3493@concordia>
In-Reply-To: <20130306035443.GB3493@concordia>
Content-Type: multipart/alternative;
 boundary="------------060504070009070202050900"
Cc: tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060504070009070202050900
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

于 2013/3/6 11:54, Michael Ellerman 写道:
> On Tue, Mar 05, 2013 at 03:19:57PM +0800, Mike Qiu wrote:
>> 于 2013/3/5 10:23, Michael Ellerman 写道:
>>> On Tue, Jan 15, 2013 at 03:38:55PM +0800, Mike Qiu wrote:
>>>> Adding a function irq_create_mapping_many() which can associate
>>>> multiple MSIs to a continous irq mapping.
>>>>
>>>> This is needed to enable multiple MSI support for pSeries.
>>>>
>>>> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>>>> ---
>>>>   include/linux/irq.h       |    2 +
>>>>   include/linux/irqdomain.h |    3 ++
>>>>   kernel/irq/irqdomain.c    |   61 +++++++++++++++++++++++++++++++++++++++++++++
>>>>   3 files changed, 66 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>>>> index 60ef45b..e00a7ec 100644
>>>> --- a/include/linux/irq.h
>>>> +++ b/include/linux/irq.h
>>>> @@ -592,6 +592,8 @@ int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
>>>>   #define irq_alloc_desc_from(from, node)		\
>>>>   	irq_alloc_descs(-1, from, 1, node)
>>>> +#define irq_alloc_desc_n(nevc, node)		\
>>>> +	irq_alloc_descs(-1, 0, nevc, node)
>>> This has been superseeded by irq_alloc_descs_from(), which is the right
>>> way to do it.
>> Yes, but irq_alloc_descs_from() just for 1 irq
> No it's not, look again.
>
> #define irq_alloc_descs_from(from, cnt, node)   \
> 	irq_alloc_descs(-1, from, cnt, node)
Sorry, I see as irq_alloc_desc_from(from, node)
you are right
>
>
>>>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>>>> index 96f3a1d..38648e6 100644
>>>> --- a/kernel/irq/irqdomain.c
>>>> +++ b/kernel/irq/irqdomain.c
>>>> @@ -636,6 +636,67 @@ int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
>>>>   }
>>>>   EXPORT_SYMBOL_GPL(irq_create_strict_mappings);
>>>> +/**
>>>> + * irq_create_mapping_many - Map a range of hw IRQs to a range of virtual IRQs
>>>> + * @domain: domain owning the interrupt range
>>>> + * @hwirq_base: beginning of continuous hardware IRQ range
>>>> + * @count: Number of interrupts to map
>>> For multiple-MSI the allocated interrupt numbers must be a power-of-2,
>>> and must be naturally aligned. I don't /think/ that's a requirement for
>>> the virtual numbers, but it's probably best that we do it anyway.
>>>
>>> So this API needs to specify that it will give you back a power-of-2
>>> block that is naturally aligned - otherwise you can't use it for MSI.
>> rtas_call will return the numbers of hardware interrupt, and it
>> should be power-of-2, as this I think do not need to specify
> You're confusing hardware interrupt numbers and virtual interrupt
> numbers. My comment is about irq_create_mapping_many(), which returns
> virtual interrupt numbers.
>
> As I said I don't think there is a requirement that the virtual
> interrupt numbers are also a power-of-2 naturally aligned block, but we
> should allocate them as one anyway, to avoid any issues in future.
But for virtual interrupt numbersit should be a power-of-2 naturally
aligned block, because it must be continuous, as the MSI-HOWTO.txt says:

     4.2.2 pci_enable_msi_block
     int pci_enable_msi_block(struct pci_dev *dev, int count)
     This variation on the above call allows a device driver to request
     multiple MSIs.  The MSI specification only allows interrupts to be
     allocated in powers of two, up to a maximum of 2^5 (32).
     If this function returns 0, it has succeeded in allocating at least
     as many interrupts as the driver requested
     (it may have allocated more in order to satisfy the power-of-two
     requirement). In this case, the function enables MSI on this device
     and updates dev->irq to be the lowest of the new interrupts
     assigned to it. The other interrupts assigned to the device are in
     the range dev->irq to dev->irq + count - 1.

See the last line, that means for the virtual interrupts must be a
continuous block.
> And so this API, which returns virtual interrupt numbers, must satisfy
> that specification.
>
>>>> +	/* Look for default domain if nececssary */
>>>> +	if (!domain)
>>>> +		domain = irq_default_domain;
>>>> +	if (!domain) {
>>>> +		pr_warn("irq_create_mapping called for NULL domain, hwirq=%lx\n"
>>>> +			, hwirq_base);
>>>> +		WARN_ON(1);
>>>> +		return 0;
>>>> +	}
>>>> +	pr_debug("-> using domain @%p\n", domain);
>>>> +
>>>> +	/* For IRQ_DOMAIN_MAP_LEGACY, get the first virtual interrupt number */
>>>> +	if (domain->revmap_type == IRQ_DOMAIN_MAP_LEGACY)
>>>> +		return irq_domain_legacy_revmap(domain, hwirq_base);
>>> The above doesn't work.
>> Why it doesn't work ?
> Because irq_domain_legacy_revmap() only allocates a single interrupt
> number.
OK, your right.
>>>> +	/* Check if mapping already exists */
>>>> +	for (i = 0; i < count; i++) {
>>>> +		virq = irq_find_mapping(domain, hwirq_base+i);
>>>> +		if (virq) {
>>>> +			pr_debug("existing mapping on virq %d,"
>>>> +					" now dispose it first\n", virq);
>>>> +			irq_dispose_mapping(virq);
>>> You might have just disposed of someone elses mapping, we shouldn't do
>>> that. It should be an error to the caller.
>> It's a good question. If the interrupt used for someone elses, why I
>> can apply it from the system?
> I agree, that would be a bug. But disposing of someone elses mapping is
> not OK.
>
>> So it may someone else forget to dispose mapping, and it never be
>> used for others as I have got the interrupt I think.
> Perhaps, but that is a bug that needs to be fixed in the code that
> forgets to dispose of the mapping.
>
> cheers
>


--------------060504070009070202050900
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">于 2013/3/6 11:54, Michael Ellerman 写道:<br>
    </div>
    <blockquote cite="mid:20130306035443.GB3493@concordia" type="cite">
      <pre wrap="">On Tue, Mar 05, 2013 at 03:19:57PM +0800, Mike Qiu wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">于 2013/3/5 10:23, Michael Ellerman 写道:
</pre>
        <blockquote type="cite">
          <pre wrap="">On Tue, Jan 15, 2013 at 03:38:55PM +0800, Mike Qiu wrote:
</pre>
          <blockquote type="cite">
            <pre wrap="">Adding a function irq_create_mapping_many() which can associate
multiple MSIs to a continous irq mapping.

This is needed to enable multiple MSI support for pSeries.

Signed-off-by: Mike Qiu <a class="moz-txt-link-rfc2396E" href="mailto:qiudayu@linux.vnet.ibm.com">&lt;qiudayu@linux.vnet.ibm.com&gt;</a>
---
 include/linux/irq.h       |    2 +
 include/linux/irqdomain.h |    3 ++
 kernel/irq/irqdomain.c    |   61 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 60ef45b..e00a7ec 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -592,6 +592,8 @@ int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 #define irq_alloc_desc_from(from, node)		\
 	irq_alloc_descs(-1, from, 1, node)
+#define irq_alloc_desc_n(nevc, node)		\
+	irq_alloc_descs(-1, 0, nevc, node)
</pre>
          </blockquote>
          <pre wrap="">This has been superseeded by irq_alloc_descs_from(), which is the right
way to do it.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">Yes, but irq_alloc_descs_from() just for 1 irq
</pre>
      </blockquote>
      <pre wrap="">
No it's not, look again.

#define irq_alloc_descs_from(from, cnt, node)   \
	irq_alloc_descs(-1, from, cnt, node)</pre>
    </blockquote>
    Sorry, I see as irq_alloc_desc_from(from, node)<br>
    you are right<br>
    <blockquote cite="mid:20130306035443.GB3493@concordia" type="cite">
      <pre wrap="">


</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 96f3a1d..38648e6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -636,6 +636,67 @@ int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
 }
 EXPORT_SYMBOL_GPL(irq_create_strict_mappings);
+/**
+ * irq_create_mapping_many - Map a range of hw IRQs to a range of virtual IRQs
+ * @domain: domain owning the interrupt range
+ * @hwirq_base: beginning of continuous hardware IRQ range
+ * @count: Number of interrupts to map
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">For multiple-MSI the allocated interrupt numbers must be a power-of-2,
and must be naturally aligned. I don't /think/ that's a requirement for
the virtual numbers, but it's probably best that we do it anyway.

So this API needs to specify that it will give you back a power-of-2
block that is naturally aligned - otherwise you can't use it for MSI.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">rtas_call will return the numbers of hardware interrupt, and it
should be power-of-2, as this I think do not need to specify
</pre>
      </blockquote>
      <pre wrap="">
You're confusing hardware interrupt numbers and virtual interrupt
numbers. My comment is about irq_create_mapping_many(), which returns
virtual interrupt numbers.

As I said I don't think there is a requirement that the virtual
interrupt numbers are also a power-of-2 naturally aligned block, but we
should allocate them as one anyway, to avoid any issues in future.
</pre>
    </blockquote>
    But for virtual
    interrupt numbersit should be a power-of-2 naturally<br>
    aligned block, because it must be <span style="color: rgb(0, 0, 0);
      font-family: arial; font-size: small; font-style: normal;
      font-variant: normal; font-weight: normal; letter-spacing: normal;
      line-height: 18px; orphans: 2; text-align: start; text-indent:
      0px; text-transform: none; white-space: normal; widows: 2;
      word-spacing: 0px; -webkit-text-size-adjust: auto;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255); display: inline !important; float: none;">continuous</span>,
    as the MSI-HOWTO.txt says:<br>
    <br>
        4.2.2 pci_enable_msi_block<br>
        int pci_enable_msi_block(struct pci_dev *dev, int count)  <br>
        This variation on the above call allows a device driver to
    request<br>
        multiple MSIs.  The MSI specification only allows interrupts to
    be<br>
        allocated in powers of two, up to a maximum of 2^5 (32).<br>
        If this function returns 0, it has succeeded in allocating at
    least<br>
        as many interrupts as the driver requested<br>
        (it may have allocated more in order to satisfy the power-of-two<br>
        requirement). In this case, the function enables MSI on this
    device<br>
        and updates dev-&gt;irq to be the lowest of the new interrupts<br>
        assigned to it. The other interrupts assigned to the device are
    in <br>
        the range dev-&gt;irq to dev-&gt;irq + count - 1.<br>
    <br>
    See the last line, that means for the virtual interrupts must be a<br>
    continuous block. <br>
    <blockquote cite="mid:20130306035443.GB3493@concordia" type="cite">
      <pre wrap="">
And so this API, which returns virtual interrupt numbers, must satisfy
that specification.

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">+	/* Look for default domain if nececssary */
+	if (!domain)
+		domain = irq_default_domain;
+	if (!domain) {
+		pr_warn("irq_create_mapping called for NULL domain, hwirq=%lx\n"
+			, hwirq_base);
+		WARN_ON(1);
+		return 0;
+	}
+	pr_debug("-&gt; using domain @%p\n", domain);
+
+	/* For IRQ_DOMAIN_MAP_LEGACY, get the first virtual interrupt number */
+	if (domain-&gt;revmap_type == IRQ_DOMAIN_MAP_LEGACY)
+		return irq_domain_legacy_revmap(domain, hwirq_base);
</pre>
          </blockquote>
          <pre wrap="">The above doesn't work.
</pre>
        </blockquote>
        <pre wrap="">Why it doesn't work ?
</pre>
      </blockquote>
      <pre wrap="">
Because irq_domain_legacy_revmap() only allocates a single interrupt
number.
</pre>
    </blockquote>
    OK, your right.<br>
    <blockquote cite="mid:20130306035443.GB3493@concordia" type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">+	/* Check if mapping already exists */
+	for (i = 0; i &lt; count; i++) {
+		virq = irq_find_mapping(domain, hwirq_base+i);
+		if (virq) {
+			pr_debug("existing mapping on virq %d,"
+					" now dispose it first\n", virq);
+			irq_dispose_mapping(virq);
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="">You might have just disposed of someone elses mapping, we shouldn't do
that. It should be an error to the caller.
</pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">It's a good question. If the interrupt used for someone elses, why I
can apply it from the system?
</pre>
      </blockquote>
      <pre wrap="">
I agree, that would be a bug. But disposing of someone elses mapping is
not OK.

</pre>
      <blockquote type="cite">
        <pre wrap="">So it may someone else forget to dispose mapping, and it never be
used for others as I have got the interrupt I think.
</pre>
      </blockquote>
      <pre wrap="">
Perhaps, but that is a bug that needs to be fixed in the code that
forgets to dispose of the mapping.

cheers

</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------060504070009070202050900--
