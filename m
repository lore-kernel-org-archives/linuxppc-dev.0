Return-Path: <wilbur512@gmail.com>
Received: from mail-yx0-f194.google.com (mail-yx0-f194.google.com
	[209.85.210.194])
	by bilbo.ozlabs.org (Postfix) with ESMTP id BC7A4B708B
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jul 2009 01:34:44 +1000 (EST)
Received: by yxe32 with SMTP id 32so5008090yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 26 Jul 2009 08:34:42 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 26 Jul 2009 23:34:42 +0800
Message-ID: <e997b7420907260834v5923326ele5af13713622c366@mail.gmail.com>
Subject: Question about head_fsl_booke.S
From: "wilbur.chan" <wilbur512@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: chelly wilbur <wilbur512@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

e500  , in  head_fsl_booke.S

We know,the first two steps are:

1) invalidate all entries except  the entry we are in

2) setup a temp mapping and jump to it  respectively:



         tlbwe

         bl  1f
     1:  mflr r9
         rlwimi  r7,r9,0,20,31
         addi r7, r7,24
         mtspr   SPRN_SRR0,r7
         mtspr   SPRN_SRR1,r6
         rfi
        /*  jump to 0-4k .
         question1:   Why not this 'rfi' did not caused jumping  into
4k-8k , or 10k-14k ,    etc ?     */

         li r6,0



question2:  We know that, it is not allowed  the two entrys having the
same EPN value,so, when setting up a temp entry which ranged from
0-4k, is it possible that , this
range(0-4k)  may conflit with the entry we are executed in now?


Thx in advance.


regards,
