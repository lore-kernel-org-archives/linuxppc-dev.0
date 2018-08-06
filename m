Return-Path: <rpjday@crashcourse.ca>
Received: from cpanel4.indieserve.net (cpanel4.indieserve.net [199.212.143.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41kkQw1MJHzF3HK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 02:59:51 +1000 (AEST)
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com
 ([174.114.57.56]:38486 helo=localhost.localdomain)
 by cpanel4.indieserve.net with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.91)
 (envelope-from <rpjday@crashcourse.ca>) id 1fmiXS-00BUjs-7S
 for linuxppc-dev@lists.ozlabs.org; Mon, 06 Aug 2018 12:39:23 -0400
Date: Mon, 6 Aug 2018 12:37:50 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
To: Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Subject: is there still any need PPC checking for "chosen@0"?
Message-ID: <alpine.LFD.2.21.1808061234580.25636@localhost.localdomain>
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


  given that there are no .dts files in the current kernel code base
that define the node name "/chosen@0" instead of the proper "/chosen",
is there any need for arch/powerpc/boot/oflib.c to still make this
test:

        chosen = of_finddevice("/chosen");
        if (chosen == (phandle) -1) {
                chosen = of_finddevice("/chosen@0");   <--- this
                if (chosen == (phandle) -1) {
                        printf("no chosen\n");
                        return 0;
                }
        }

are there still PPC machines that require the recognition of
"/chosen@0"?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
