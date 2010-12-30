Return-Path: <b25806@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7313FB70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 19:16:10 +1100 (EST)
Content-Type: text/plain; charset="utf-8"; format=flowed; delsp=yes
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3 v2] of/device: Register children with a compatible
	value in of_platform_bus_probe()
References: <1291978340-15933-1-git-send-email-b25806@freescale.com>
	<20101230065045.GB843@angua.secretlab.ca>
	<op.voimsxy9z91x4h@localhost.localdomain>
	<20101230073157.GC843@angua.secretlab.ca>
Date: Thu, 30 Dec 2010 16:04:10 +0800
MIME-Version: 1.0
From: Lan Chunhe <b25806@freescale.com>
Message-ID: <op.voioo8pqz91x4h@localhost.localdomain>
In-Reply-To: <20101230073157.GC843@angua.secretlab.ca>
Cc: akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
	dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 30 Dec 2010 15:31:57 +0800, Grant Likely  
<grant.likely@secretlab.ca> wrote:

> On Thu, Dec 30, 2010 at 03:23:11PM +0800, Lan Chunhe wrote:
>> On Thu, 30 Dec 2010 14:50:45 +0800, Grant Likely
>> <grant.likely@secretlab.ca> wrote:
>>
>> >On Fri, Dec 10, 2010 at 06:52:20PM +0800, Lan Chunhe wrote:
>> >>Currently, of_platform_bus_probe() completely skips nodes which do not
>> >>explicitly match the 'matches' table passed in.  Or, if the root node
>> >>matches, then it registers all the children unconditionally.  However,
>> >>there are situations, such as registering devices from the root node,
>> >>when it is desirable to register child nodes, but only if they  
>> actually
>> >>represent devices.  For example, the root node may contain both a  
>> local
>> >>bus and a PCI device, but it also contains the chosen, aliases and  
>> cpus
>> >>nodes which don't represent real devices.
>> >>
>> >>This patch changes of_platform_bus_probe() to register all nodes at  
>> the
>> >>top level if they either match the matches table (the current
>> >>behaviour),
>> >>or if they have a 'compatible' value (indicating it represents a
>> >>device).
>> >>
>> >>Signed-off-by: Lan Chunhe <b25806@freescale.com>
>> >
>> >I believe this is my patch I wrote and pushed out to my tree back in
>> >October.  Was this cherry-picked out of the test-devicetree branch?
>>
>>    Yes, I will add the signed off with you.
>>
>>      Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>> >>Signed-off-by: Lan Chunhe <b25806@freescale.com>
>>
>>    At present I think that it is cherry-picked, and I have tested it  
>> which
>>    is OK.
>>    Do you have better method?
>
> You need to be very careful about stuff like this.  Posting a patch
> without attribution of the original author and has the original
> signed-off-by lines stripped off is an absolute no-no.  In literary
> circles this would be called plagiarism.
>
> I don't think you did it intentionally, but proper attribution is a
> must, particularly because there are copyright issues involved.

    Sorry, thank you that you remind me.

> As for this particular patch, I'm not particularly happy with it and I
> was planning to rewrite it.  It is an inelegant solution and I think
> the registration of devices from the device tree can be made simpler
> instead of more complex like in this patch.

    Now this patch registers devices from the device tree.
    Then which function of which file do you will modify?

    Thanks.
    -Lan
> g.
>
>>
>>    Thanks.
>>    -Lan
>>
>> >>---
>> >> drivers/of/platform.c |   28 +++++++++++++++++++++++-----
>> >> 1 files changed, 23 insertions(+), 5 deletions(-)
>> >>
>> >>diff --git a/drivers/of/platform.c b/drivers/of/platform.c
>> >>index 5b4a07f..02755ab 100644
>> >>--- a/drivers/of/platform.c
>> >>+++ b/drivers/of/platform.c
>> >>@@ -714,6 +714,8 @@ int of_platform_bus_probe(struct device_node  
>> *root,
>> >> 	struct device_node *child;
>> >> 	struct platform_device *dev;
>> >> 	int rc = 0;
>> >>+	const void *compat;
>> >>+	const struct of_device_id *match;
>> >>
>> >> 	if (WARN_ON(!matches || matches == OF_NO_DEEP_PROBE))
>> >> 		return -EINVAL;
>> >>@@ -741,16 +743,32 @@ int of_platform_bus_probe(struct
>> >>device_node *root,
>> >> 		rc = of_platform_bus_create(root, matches, &dev->dev);
>> >> 		goto bail;
>> >> 	}
>> >>+
>> >>+	/*
>> >>+	 * Register each child node if either:
>> >>+	 *  a) it has a 'compatible' value indicating they are a device, or
>> >>+	 *  b) it is specified by the 'matches' table (by name or  
>> device_type)
>> >>+	 * If a node is specified in the matches table, then all its  
>> children
>> >>+	 * also get registered.
>> >>+	 */
>> >> 	for_each_child_of_node(root, child) {
>> >>-		if (!of_match_node(matches, child))
>> >>+		compat = of_get_property(child, "compatible", NULL);
>> >>+		match = of_match_node(matches, child);
>> >>+		if (!compat && !match)
>> >> 			continue;
>> >>
>> >>-		pr_debug("  match: %s\n", child->full_name);
>> >>+		pr_debug("  register device: %s\n", child->full_name);
>> >> 		dev = of_platform_device_create(child, NULL, parent);
>> >>-		if (dev == NULL)
>> >>+		if (!dev) {
>> >> 			rc = -ENOMEM;
>> >>-		else
>> >>-			rc = of_platform_bus_create(child, matches, &dev->dev);
>> >>+			of_node_put(child);
>> >>+			break;
>> >>+		}
>> >>+		if (!match)
>> >>+			continue;
>> >>+
>> >>+		pr_debug("  register children of: %s\n", child->full_name);
>> >>+		rc = of_platform_bus_create(child, matches, &dev->dev);
>> >> 		if (rc) {
>> >> 			of_node_put(child);
>> >> 			break;
>> >>--
>> >>1.5.4.5
>> >>
>> >>
>> >
>>
>>
>
