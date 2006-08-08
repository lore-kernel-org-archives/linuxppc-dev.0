Return-Path: <jimix@watson.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B04BB67B5E
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 02:13:43 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k78GDaTB012596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 12:13:37 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k78GDaF7289480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 12:13:36 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k78GDaFq002796
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Aug 2006 12:13:36 -0400
In-Reply-To: <17624.6035.613234.492868@cargo.ozlabs.ibm.com>
References: <E1G9jpY-0004Nv-2d@kmac.watson.ibm.com>
	<17624.6035.613234.492868@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8E2F2404-1F0D-46BD-94EC-743EC018E79D@watson.ibm.com>
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Re: [RFC] Debugging with a HW probe.
Date: Tue, 8 Aug 2006 12:13:35 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 8, 2006, at 12:48 AM, Paul Mackerras wrote:

> Jimi Xenidis writes:
>
>> +static noinline void xmon_hw_probe(void)
>> +{
>> +	if (!xmon_hw_probe_enabled)
>> +		return;
>> +	ATTN();
>> +}
>
> I can't see how we can get to call this routine with
> xmon_hw_probe_enabled equal to 0...  What am I missing?
>

@@ -834,6 +904,11 @@ #ifdef CONFIG_PPC_STD_MMU
  			dump_segments();
  			break;
  #endif
+#ifdef CONFIG_XMON_ATTN
+		case 'A':
+			xmon_hw_probe();
+			break;
+#endif
  		default:
  			printf("Unrecognized command: ");
  		        do {

The static is used to avoid the illegal instruction trap that will/ 
should occur if we execute this instruction and the hid bit is not set.

-JX
