Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50])
 by lists.ozlabs.org (Postfix) with ESMTP id 6545B1A0194
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 05:46:46 +1000 (EST)
Date: Wed, 17 Sep 2014 20:34:52 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Kumar Gala <galak@codeaurora.org>
Subject: Re: [RFC PATCH] dt:numa: adding numa node mapping for memory nodes.
Message-ID: <20140917193452.GD7983@leverpostej>
References: <1410944189-3608-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <A4205FCA-D4DE-48A4-B19F-58400A3FBF5C@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <A4205FCA-D4DE-48A4-B19F-58400A3FBF5C@codeaurora.org>
Cc: "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>,
 Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Rob Herring <robh+dt@kernel.org>,
 Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "gpkulkarni@gmail.com" <gpkulkarni@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 17, 2014 at 04:37:30PM +0100, Kumar Gala wrote:
> 
> On Sep 17, 2014, at 1:56 AM, Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com> wrote:
> 
> > From: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > 
> > This patch adds property "nid" to memory node to provide the memory range to
> > numa node id mapping.
> > 
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > 
> > —
> 
> Adding the PPC guys as they’ve been doing NUMA on IBM Power Servers
> for years with OF/DT.  So we should really try and follow what they’ve
> done.

Agreed.

> > Documentation/devicetree/bindings/numa.txt | 58 ++++++++++++++++++++++++++++++
> > 1 file changed, 58 insertions(+)
> > create mode 100644 Documentation/devicetree/bindings/numa.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> > new file mode 100644
> > index 0000000..c4a94f2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/numa.txt
> > @@ -0,0 +1,58 @@
> > +======================================================
> > +numa id binding description
> > +======================================================
> > +
> > +======================================================
> > +1 - Introduction
> > +======================================================
> > +The device node  property "nid(numa node id)" can be added to memory

Why the quotes?

> > +device node to map the range of memory addresses as defined in property "reg".
> > +The property "nid" maps the memory range to the numa node id, which is used to
> > +find the local and remory pages on numa aware systems.

What is a "numa node id", exactly, and how is the OS intended to use it?

I don't see how this can be of any use as-is.

Mark.

> > +
> > +======================================================
> > +2 - nid property
> > +======================================================
> > +Numa node id, "nid" is required property of memory device node for 
> > +numa enabled platforms.
> > +
> > +|------------------------------------------------------|
> > +|Property Type  | Usage | Value Type | Definition      |
> > +|------------------------------------------------------|
> > +|  nid          |  R    |    <u32>   | Numa Node id    |
> > +|               |       |            | for this memory |
> > +|------------------------------------------------------|
> > +
> > +========================================================
> > +4 - Example memory nodes with numa node id mapping
> > +========================================================
> > +
> > +Example 1 (2 memory nodes, each mapped to a numa node.):
> > +
> > +	memory@00000000 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x00000000 0x0 0x80000000>;
> > +		nid = <0x0>;
> > +	};
> > +
> > +	memory@10000000000 {
> > +		device_type = "memory";
> > +		reg = <0x100 0x00000000 0x0 0x80000000>;
> > +		nid = <0x1>;
> > +	};
> > +
> > +Example 2 (multiple memory ranges in each memory node and mapped to numa node):
> > +
> > +	memory@00000000 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x00000000 0x0 0x80000000>,
> > +		      <0x0 0x80000000 0x0 0x80000000>;
> > +		nid = <0x0>;
> > +	};
> > +
> > +	memory@10000000000 {
> > +		device_type = "memory";
> > +		reg = <0x100 0x00000000 0x0 0x80000000>,
> > +		      <0x100 0x80000000 0x0 0x80000000>;
> > +		nid = <0x1>;
> > +	};
> > -- 
> > 1.8.1.4
> > 
> 
> -- 
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
