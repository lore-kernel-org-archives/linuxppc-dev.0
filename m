Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B65CB1A0673
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 17:12:52 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 12 Nov 2015 16:12:51 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 96DDC2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 17:12:46 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAC6CcE054132794
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 17:12:46 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAC6CD8o009685
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 17:12:14 +1100
Date: Thu, 12 Nov 2015 17:11:48 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 37/50] powerpc/powernv: Simplify pnv_eeh_reset()
Message-ID: <20151112061148.GA17357@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-38-git-send-email-gwshan@linux.vnet.ibm.com>
 <877flniyz3.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <877flniyz3.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 12, 2015 at 04:11:12PM +1100, Daniel Axtens wrote:
>> -			rc = opal_pci_reset(phb->opal_id,
>> -					    OPAL_RESET_PHB_ERROR,
>> -					    OPAL_ASSERT_RESET);
>> -			if (rc != OPAL_SUCCESS) {
>> -				pr_warn("%s: Failure %lld clearing "
>> -					"error injection registers\n",
>> -					__func__, rc);
>
>This is very minor, but is there a good reason to change the error
>message from the one above to the one below? I just hesitate to change
>error messages that people might be grepping the source for without a
>good reason.
>

About 3 years ago, I think the error message printed by pr_warn() can't
exceed 80 lines each line. Otherwise, scripts/checkpatch.pl will report
warnings. The error message spans multiple lines to avoid that. However,
that turned to be wrong later. If people searchs the code from the error
or warning message, it'd better to keep it in one line, not in multiple
lines. That's the reason I merged them into one line since I have to
refactor the function. At same time, the message is shortened as "Error"
is shorter than "Failure" and "registers" in original message is meaningless.

>> +		if (rc != OPAL_SUCCESS) {
>> +			pr_warn("%s: Error %lld clearing error injection\n",
>> +				__func__, rc);
>
>Apart from that this looks good, pending me actually testing it :)
>

Thanks :-)

Gavin

>Regards,
>Daniel
>
