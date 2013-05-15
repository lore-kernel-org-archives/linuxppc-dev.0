Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A9DE2C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 15:31:01 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 15 May 2013 01:30:58 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 9757AC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 01:30:54 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F5UsRj240618
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 01:30:54 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F5UsY0019798
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 02:30:54 -0300
Date: Wed, 15 May 2013 13:30:49 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v1 00/22] powerpc/eeh: Enhance converting EEH dev
Message-ID: <20130515053049.GA28780@shangw.(null)>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1368590264.31689.69.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1368590264.31689.69.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 15, 2013 at 01:57:44PM +1000, Benjamin Herrenschmidt wrote:
>On Wed, 2013-05-15 at 11:34 +0800, Gavin Shan wrote:
>> e don't have existing utility (e.g. errinjct) to test the patchset. In order
>> to conduct the test, you need copy over the eeh-debug.c to PowerNV platform
>> directory and change the makefile accordingly. Please contact me to get the
>> eeh-debug.c if you want run the test case. After that, you need write P7IOC
>> registers explicitly to trigger frozen PE or fenced PHB explicitly as the
>> following example shows. The patchset has been verified on Firebird-L machine
>> where I have 2 Emulex ethernet card on PHB#6. I keep pinging to one of the
>> ethernet cards from external and then use following commands to produce frozen
>> PE or fenced PHB errors. Eventually, the errors can be recovered and the ethernet
>> card is reachable after temporary connection lost.
>
>There is an error injection framework we can use nowadays, or maybe you can
>put this in tools/powerpc ?
>

Ben, we don't have error injection framework yet. I have one source file "eeh-debug.c"
which exports P7IOC registers through procfs. In order to force EEH errors (frozen PE
or fenced PHB), we need change the specific bits of corresponding HW registers through
the procfs entries (e.g. /proc/IODA/PHBx/REG).

Thanks,
Gavin
