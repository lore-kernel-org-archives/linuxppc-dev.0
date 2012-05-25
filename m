Return-Path: <steffen.rumler.ext@nsn.com>
Received: from demumfd002.nsn-inter.net (demumfd002.nsn-inter.net
 [93.183.12.31])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "demumfd002.nsn-inter.net",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A33CDB6EE6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 18:14:13 +1000 (EST)
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
 by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id
 q4P7uOT3012404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 09:56:24 +0200
Received: from mango.dwdm.mu.nsn-intra.net ([10.148.33.2])
 by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id
 q4P7uNIm009778
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 09:56:24 +0200
Message-ID: <4FBF3B17.1040106@nsn.com>
Date: Fri, 25 May 2012 09:56:07 +0200
From: Steffen Rumler <steffen.rumler.ext@nsn.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: module loading issue/flaw in busy memory situation?
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

The basic question is, has the GPR r11 a dedicated function (to point to the previous stack frame)
or is it still a volatile GPR, according to EABI definition ?
In the case of a dedicated function was assigned, the trampoline code generation in

     arch/powerpc/kernel/module_32.c

must be corrected. I'd suggest to use r12 instead of r11, in this case.

Best Regards
Steffen
