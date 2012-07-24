Return-Path: <B04825@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe002.messaging.microsoft.com [213.199.154.140])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0C50B2C0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2012 00:43:25 +1000 (EST)
Received: from mail12-db3 (localhost [127.0.0.1])	by mail12-db3-R.bigfish.com
 (Postfix) with ESMTP id 764E620256	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 24 Jul 2012 14:43:18 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.253])	by
 mail12-db3.bigfish.com (Postfix) with ESMTP id 934F4360260	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2012 14:43:16 +0000 (UTC)
Message-ID: <500EB47F.1040903@freescale.com>
Date: Tue, 24 Jul 2012 09:43:11 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Singh Sandeep-B37400 <B37400@freescale.com>
Subject: Re: [2/3][PATCH][upstream] TDM Framework
References: <1343040588-16002-1-git-send-email-b37400@freescale.com>
 <CAOZdJXVnEUEQesyG52pL_jerGDrmJLxdfBNFrj_xvhPs=ue4DA@mail.gmail.com>
 <3F1D9DCAAB49B94D88DBE05911FA4E6E50ED27@039-SN1MPN1-006.039d.mgd.msft.net>
In-Reply-To: <3F1D9DCAAB49B94D88DBE05911FA4E6E50ED27@039-SN1MPN1-006.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Aggrwal Poonam-B10812 <B10812@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Singh Sandeep-B37400 wrote:

>> +int tdm_adap_send(struct tdm_adapter *adap, void **buf, int count) {
>> +       int res;
>> +
>> +       if (adap->algo->tdm_write)
>> +               res = adap->algo->tdm_write(adap, buf, count);
> 
> Why does tdm_write() return a u32?  And shouldn't 'res' also be a u32, to make tdm_write()?
> [Sandeep] tdm_write() returns number of bytes written. You are right, 'res' should be declared as u32

Then it should return an unsigned int.  You should used a sized integer
type only when the size really matters (e.g. hardware registers or packed
fields in a structure).

>> +/* tdm_adapter_mode is to define in mode of the device */ enum 
>> +tdm_adapter_mode {
>> +       TDM_ADAPTER_MODE_NONE = 0x00,
>> +       TDM_ADAPTER_MODE_T1 = 0x01,
>> +       TDM_ADAPTER_MODE_E1 = 0x02,
>> +       TDM_ADAPTER_MODE_T1_RAW = 0x10,
>> +       TDM_ADAPTER_MODE_E1_RAW = 0x20,
> 
> Where did these numbers come from?
> [Sandeep] This is not related to any bit definition, just enum values.

Yes, but why these particular numbers?  Also, do they really need to be an
enum?  Since you're defining hard values for each enum, you're not really
using them as an enum.  Make these into macros.


-- 
Timur Tabi
Linux kernel developer at Freescale
