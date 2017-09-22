Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzFBd5BPSzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 23:46:32 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8MDhZGO124986
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 09:46:30 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d53mfgbgj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 09:46:29 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Fri, 22 Sep 2017 09:46:29 -0400
Subject: Re: [PATCH v1 1/3] powerpc/kernel: Split up pci_bus_add_device
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: bhelgaas@google.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "Juan J . Alvarez" <jjalvare@us.ibm.com>
References: <20170918192651.78404-1-bryantly@linux.vnet.ibm.com>
 <20170918192651.78404-2-bryantly@linux.vnet.ibm.com>
 <20170921204326.GJ22312@bhelgaas-glaptop.roam.corp.google.com>
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Date: Fri, 22 Sep 2017 08:46:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170921204326.GJ22312@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: multipart/alternative;
 boundary="------------0B9EC22EE5D642BE41404790"
Message-Id: <1a13b02a-4e32-adff-1083-8bf538cbdf9b@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------0B9EC22EE5D642BE41404790
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/21/17 3:43 PM, Bjorn Helgaas wrote:
> On Mon, Sep 18, 2017 at 02:26:49PM -0500, Bryant G. Ly wrote:
>> When enabling SR-IOV one might want to have their
>> own version of starting device drivers for the VFs.
>> This patch allows for SR-IOV callers to use
>> pci_bus_add_virtfn_device instead of generic
>> pci_bus_add_device.
>>
>> When enabling SR-IOV in PSeries architecture the
>> dynamic VFs created within the sriov_configure sysfs call
>> will not load the device driver as firmware will load
>> the device node when the VF device is assigned to the
>> logical partition. So we needed a way to overwrite the
>> way device driver matching is done for virtual functions
>> on powervm.
>>
>> Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
>> Signed-off-by: Juan J. Alvarez <jjalvare@us.ibm.com>
>> ---
>>   drivers/pci/bus.c   | 51 ++++++++++++++++++++++++++++++++++++++++++---------
>>   drivers/pci/iov.c   |  2 +-
>>   include/linux/pci.h |  3 +++
>>   3 files changed, 46 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index bc56cf19afd3..86daf62c4048 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -302,16 +302,9 @@ void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
>>   
>>   void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
>>   
>> -/**
>> - * pci_bus_add_device - start driver for a single device
>> - * @dev: device to add
>> - *
>> - * This adds add sysfs entries and start device drivers
>> - */
>> -void pci_bus_add_device(struct pci_dev *dev)
>> -{
>> -	int retval;
>>   
>> +void pci_bus_add_sysfs_entries(struct pci_dev *dev)
>> +{
>>   	/*
>>   	 * Can not put in pci_device_add yet because resources
>>   	 * are not assigned yet for some devices.
>> @@ -321,6 +314,11 @@ void pci_bus_add_device(struct pci_dev *dev)
>>   	pci_create_sysfs_dev_files(dev);
>>   	pci_proc_attach_device(dev);
>>   	pci_bridge_d3_update(dev);
>> +}
>> +
>> +void pci_bus_match_device_driver(struct pci_dev *dev)
>> +{
>> +	int retval;
>>   
>>   	dev->match_driver = true;
>>   	retval = device_attach(&dev->dev);
>> @@ -333,6 +331,41 @@ void pci_bus_add_device(struct pci_dev *dev)
>>   
>>   	dev->is_added = 1;
>>   }
>> +
>> +#ifdef CONFIG_PCI_IOV
>> +void __weak pci_bus_match_virtfn_driver(struct pci_dev *dev)
>> +{
>> +	pci_bus_match_device_driver(dev);
>> +}
>> +
>> +/**
>> + * pci_bus_add_virtfn_device - start driver for a virtual function device
>> + * @dev: device to add
>> + *
>> + * This adds add sysfs entries and start device drivers for
>> + * virtual function devices
>> + *
>> + */
>> +void pci_bus_add_virtfn_device(struct pci_dev *pdev)
>> +{
>> +	pci_bus_add_sysfs_entries(pdev);
>> +	pci_bus_match_virtfn_driver(pdev);
>> +}
>> +EXPORT_SYMBOL_GPL(pci_bus_add_virtfn_device);
> Is there any way we can avoid adding this new interface?  I don't
> really want a new global exported symbol just to support this highly
> platform-specific functionality.
>
> If we could figure out a way to set dev->match_driver to false instead
> of true in pci_bus_add_device(), it *looks* like that would be enough
> to accomplish what you need.  Maybe that could be done via a pcibios
> hook or a new function pointer in struct pci_host_bridge, similar to
> the swizzle_irq pointer?

Yes! I will remove the first two patches in the series and only utilize the third
patch but addingpdev->match_driver = -1; under pseries_pcibios_bus_add_device, which is 
a new function I added for machine dependent bus add of a device. The 
patch will then require https://patchwork.kernel.org/patch/9882915/ 
which basically allows for match_driver state to not get changed later 
under the pci_bus_match due to allowing for the match_driver to be a int 
vs a bool. I will push up another patch removing the first two patches 
and adding that extra line. -Bryant

>> +#endif
>> +
>> +/**
>> + * pci_bus_add_device - start driver for a single device
>> + * @dev: device to add
>> + *
>> + * This adds add sysfs entries and start device drivers
>> + */
>> +void pci_bus_add_device(struct pci_dev *dev)
>> +{
>> +	pci_bus_add_sysfs_entries(dev);
>> +	pci_bus_match_device_driver(dev);
>> +}
>> +
>>   EXPORT_SYMBOL_GPL(pci_bus_add_device);
>>   
>>   /**
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index ac41c8be9200..16cc72545847 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -162,7 +162,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
>>   
>>   	pci_device_add(virtfn, virtfn->bus);
>>   
>> -	pci_bus_add_device(virtfn);
>> +	pci_bus_add_virtfn_device(virtfn);
>>   	sprintf(buf, "virtfn%u", id);
>>   	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>>   	if (rc)
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index f68c58a93dd0..39f5c0b4bf23 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -911,6 +911,9 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
>>   void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
>>   unsigned int pci_scan_child_bus(struct pci_bus *bus);
>>   void pci_bus_add_device(struct pci_dev *dev);
>> +#ifdef CONFIG_PCI_IOV
>> +void pci_bus_add_virtfn_device(struct pci_dev *dev);
>> +#endif
>>   void pci_read_bridge_bases(struct pci_bus *child);
>>   struct resource *pci_find_parent_resource(const struct pci_dev *dev,
>>   					  struct resource *res);
>> -- 
>> 2.11.0 (Apple Git-81)
>>


--------------0B9EC22EE5D642BE41404790
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 9/21/17 3:43 PM, Bjorn Helgaas
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20170921204326.GJ22312@bhelgaas-glaptop.roam.corp.google.com">
      <pre wrap="">On Mon, Sep 18, 2017 at 02:26:49PM -0500, Bryant G. Ly wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">When enabling SR-IOV one might want to have their
own version of starting device drivers for the VFs.
This patch allows for SR-IOV callers to use
pci_bus_add_virtfn_device instead of generic
pci_bus_add_device.

When enabling SR-IOV in PSeries architecture the
dynamic VFs created within the sriov_configure sysfs call
will not load the device driver as firmware will load
the device node when the VF device is assigned to the
logical partition. So we needed a way to overwrite the
way device driver matching is done for virtual functions
on powervm.

Signed-off-by: Bryant G. Ly <a class="moz-txt-link-rfc2396E" href="mailto:bryantly@linux.vnet.ibm.com">&lt;bryantly@linux.vnet.ibm.com&gt;</a>
Signed-off-by: Juan J. Alvarez <a class="moz-txt-link-rfc2396E" href="mailto:jjalvare@us.ibm.com">&lt;jjalvare@us.ibm.com&gt;</a>
---
 drivers/pci/bus.c   | 51 ++++++++++++++++++++++++++++++++++++++++++---------
 drivers/pci/iov.c   |  2 +-
 include/linux/pci.h |  3 +++
 3 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc56cf19afd3..86daf62c4048 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -302,16 +302,9 @@ void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
 
 void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
 
-/**
- * pci_bus_add_device - start driver for a single device
- * @dev: device to add
- *
- * This adds add sysfs entries and start device drivers
- */
-void pci_bus_add_device(struct pci_dev *dev)
-{
-	int retval;
 
+void pci_bus_add_sysfs_entries(struct pci_dev *dev)
+{
 	/*
 	 * Can not put in pci_device_add yet because resources
 	 * are not assigned yet for some devices.
@@ -321,6 +314,11 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_create_sysfs_dev_files(dev);
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
+}
+
+void pci_bus_match_device_driver(struct pci_dev *dev)
+{
+	int retval;
 
 	dev-&gt;match_driver = true;
 	retval = device_attach(&amp;dev-&gt;dev);
@@ -333,6 +331,41 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	dev-&gt;is_added = 1;
 }
+
+#ifdef CONFIG_PCI_IOV
+void __weak pci_bus_match_virtfn_driver(struct pci_dev *dev)
+{
+	pci_bus_match_device_driver(dev);
+}
+
+/**
+ * pci_bus_add_virtfn_device - start driver for a virtual function device
+ * @dev: device to add
+ *
+ * This adds add sysfs entries and start device drivers for
+ * virtual function devices
+ *
+ */
+void pci_bus_add_virtfn_device(struct pci_dev *pdev)
+{
+	pci_bus_add_sysfs_entries(pdev);
+	pci_bus_match_virtfn_driver(pdev);
+}
+EXPORT_SYMBOL_GPL(pci_bus_add_virtfn_device);
</pre>
      </blockquote>
      <pre wrap="">
Is there any way we can avoid adding this new interface?  I don't
really want a new global exported symbol just to support this highly
platform-specific functionality.

If we could figure out a way to set dev-&gt;match_driver to false instead
of true in pci_bus_add_device(), it *looks* like that would be enough
to accomplish what you need.  Maybe that could be done via a pcibios
hook or a new function pointer in struct pci_host_bridge, similar to
the swizzle_irq pointer?
</pre>
    </blockquote>
    <pre>Yes! I will remove the first two patches in the series and only utilize the third
patch but adding <span class="blob-code-inner" style="box-sizing: border-box; overflow: visible; font-family: SFMono-Regular,Consolas,&quot;Liberation Mono&quot;,Menlo,Courier,monospace; font-size: 12px; overflow-wrap: break-word; white-space: pre-wrap; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-transform: none; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-style: initial; text-decoration-color: initial;">pdev-&gt;match_driver = -<span class="pl-c1" style="box-sizing: border-box;">1</span>; under <tt>pseries_pcibios_bus_add_device, which
is a new function I added for machine dependent bus add of a device. 

The patch will then require <a class="moz-txt-link-freetext" href="https://patchwork.kernel.org/patch/9882915/">https://patchwork.kernel.org/patch/9882915/</a>
which basically allows for match_driver state to not get changed later under the
pci_bus_match due to allowing for the match_driver to be a int vs a bool. 

I will push up another patch removing the first two patches and adding that extra line.

-Bryant</tt></span></pre>
    <blockquote type="cite"
      cite="mid:20170921204326.GJ22312@bhelgaas-glaptop.roam.corp.google.com">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">+#endif
+
+/**
+ * pci_bus_add_device - start driver for a single device
+ * @dev: device to add
+ *
+ * This adds add sysfs entries and start device drivers
+ */
+void pci_bus_add_device(struct pci_dev *dev)
+{
+	pci_bus_add_sysfs_entries(dev);
+	pci_bus_match_device_driver(dev);
+}
+
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
 /**
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index ac41c8be9200..16cc72545847 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -162,7 +162,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id, int reset)
 
 	pci_device_add(virtfn, virtfn-&gt;bus);
 
-	pci_bus_add_device(virtfn);
+	pci_bus_add_virtfn_device(virtfn);
 	sprintf(buf, "virtfn%u", id);
 	rc = sysfs_create_link(&amp;dev-&gt;dev.kobj, &amp;virtfn-&gt;dev.kobj, buf);
 	if (rc)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f68c58a93dd0..39f5c0b4bf23 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -911,6 +911,9 @@ struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
 void pci_device_add(struct pci_dev *dev, struct pci_bus *bus);
 unsigned int pci_scan_child_bus(struct pci_bus *bus);
 void pci_bus_add_device(struct pci_dev *dev);
+#ifdef CONFIG_PCI_IOV
+void pci_bus_add_virtfn_device(struct pci_dev *dev);
+#endif
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
-- 
2.11.0 (Apple Git-81)

</pre>
      </blockquote>
      <pre wrap="">
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------0B9EC22EE5D642BE41404790--
