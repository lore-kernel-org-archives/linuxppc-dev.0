Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 160A81A0008
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jun 2014 20:44:24 +1000 (EST)
Message-ID: <53919B83.4070308@suse.de>
Date: Fri, 06 Jun 2014 12:44:19 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 1/4] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1401970085-14493-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1401970085-14493-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.06.14 14:08, Aneesh Kumar K.V wrote:
> virtual time base register is a per VM, per cpu register that needs
> to be saved and restored on vm exit and entry. Writing to VTB is not
> allowed in the privileged mode.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

For some reason BUG() doesn't always trigger the "execution stops here" 
logic in gcc. So I've squashed this patch into yours.


Alex


diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 3e7085d..99de6ad 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1206,6 +1206,7 @@ static inline unsigned long mfvtb (void)
       * capture that.
       */
      BUG();
+    return 0;
  }

  #ifdef __powerpc64__
