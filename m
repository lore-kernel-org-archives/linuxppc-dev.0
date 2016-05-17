Return-Path: <rpjday@crashcourse.ca>
Received: from smtp486.redcondor.net (smtp486.redcondor.net [208.80.204.86])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8H8W3RX0zDq8G
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 22:44:25 +1000 (AEST)
Received: from astoria.ccjclearline.com ([64.235.106.9])
 by smtp486.redcondor.net ({6695537a-536a-45f9-a249-877c85428649})
 via TCP (outbound) with ESMTPS id 20160517124422334_0486
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 May 2016 12:44:22 +0000
Received: from [216.191.234.70] (port=54256 helo=crashcourse.ca)
 by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
 (Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
 id 1b2eNo-0000v8-Ez
 for linuxppc-dev@lists.ozlabs.org; Tue, 17 May 2016 08:45:56 -0400
Date: Tue, 17 May 2016 08:43:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Subject: for muram in DTS file, why change #address-cells from <1> to <2>?
Message-ID: <alpine.LFD.2.20.1605170839440.3461@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


  currently working on a project involving MPC8360 board, and was
handed a patch to the system .dts file that contained the following
snippet for the muram node:

                muram@10000 {
-                       #address-cells = <1>;
+                       #address-cells = <2>;
                        #size-cells = <1>;
                        compatible = "fsl,qe-muram", "fsl,cpm-muram";
-                       ranges = <0 0x10000 0xc000>;
+                       ranges = <0 0 0x10000 0xc000>;

                        data-only@0 {
                                compatible = "fsl,qe-muram-data","fsl,cpm-muram-data";
-                               reg = <0 0xc000>;
+                               reg = <0 0x4000 0x4000>, <0 0x9400 0x1c00>;
                        };

                };

  i'm not a .dts file expert, but i'm baffled by the change in the
value of #address-cells. how does that make any sense? it seems to me
that that kind of change is a *really* fundamental change in the
specification of the underlying architecture.

  can someone explain what that might mean? thanks.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
