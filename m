Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 06FE12C0120
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 04:56:27 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 14:56:24 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 2920C38C8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:56:21 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3NIuLCh253030
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:56:21 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3NIuJ7s010808
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 15:56:19 -0300
Message-ID: <5176D950.9010507@linux.vnet.ibm.com>
Date: Tue, 23 Apr 2013 13:56:16 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v3 5/12] Update firmware_has_feature() to check
 architecture bits
References: <51757951.2080007@linux.vnet.ibm.com>
 <517583B7.1070300@linux.vnet.ibm.com>
 <20130423115002.3d321e6a69ed97d134127a2b@canb.auug.org.au>
In-Reply-To: <20130423115002.3d321e6a69ed97d134127a2b@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2013 08:50 PM, Stephen Rothwell wrote:
> Hi Nathan,
> 
> On Mon, 22 Apr 2013 13:38:47 -0500 Nathan Fontenot <nfont@linux.vnet.ibm.com> wrote:
>>
>> -/* Option vector 5: PAPR/OF options supported */
>> -#define OV5_LPAR		0x80	/* logical partitioning supported */
>> -#define OV5_SPLPAR		0x40	/* shared-processor LPAR supported */
>> +/* Option vector 5: PAPR/OF options supported
>> + * Thses bits are also used for the platform_has_feature() call so
>       ^^^^^
> typo

will fix.

> 
>> + * we encode the vector index in the define and use the OV5_FEAT()
>> + * and OV5_INDX() macros to extract the desired information.
>> + */
>> +#define OV5_FEAT(x)	((x) & 0xff)
>> +#define OV5_INDX(x)	((x) >> 8)
>> +#define OV5_LPAR		0x0280	/* logical partitioning supported */
>> +#define OV5_SPLPAR		0x0240	/* shared-processor LPAR supported */
> 
> Wouldn't it be clearer to say
> 
> #define OV5_LPAR	(OV5_INDX(0x2) | OV5_FEAT(0x80))

The defines won't work the way you used them, they were designed to take the
combined value, i.e. 0x0280, and parse out the index and the feature.

I do think having macros to create the actual values as your example does is easier
to read. We could do something like...

#define OV5_FEAT(x)	((x) & 0xff)
#define OV5_SETINDX(x)	((x) << 8)
#define OV5_GETINDX(x)	((x) >> 8)

#define OV5_LPAR	(OV5_SETINDX(0x2) | OV5_FEAT(0x80))

Thoughts?

> 
> etc?
> 
>> @@ -145,6 +141,7 @@
>>   * followed by # option vectors - 1, followed by the option vectors.
>>   */
>>  extern unsigned char ibm_architecture_vec[];
>> +bool platform_has_feature(unsigned int);
> 
> "extern", please (if nothing else, for consistency).
> 

That shouldn't really be there, its an artifact from a previous patch. I'll remove it.

>> +static __initdata struct vec5_fw_feature
>> +vec5_fw_features_table[FIRMWARE_MAX_FEATURES] = {
> 
> Why make this array FIRMWARE_MAX_FEATURES (63) long?  You could just
> restrict the for loop below to ARRAY_SIZE(vec5_fw_features_table).
> 
>> +	{FW_FEATURE_TYPE1_AFFINITY,	OV5_TYPE1_AFFINITY},
>> +};
>> +
>> +void __init fw_vec5_feature_init(const char *vec5, unsigned long len)
>> +{
>> +	unsigned int index, feat;
>> +	int i;
>> +
>> +	pr_debug(" -> fw_vec5_feature_init()\n");
>> +
>> +	for (i = 0; i < FIRMWARE_MAX_FEATURES; i++) {
>> +		if (!vec5_fw_features_table[i].feature)
>> +			continue;
> 
> And this test could go away.
> 
> I realise that you have just copied the existing code, but you should not
> do that blindly.  Maybe you could even add an (earlier) patch that fixes
> the existing code.

I think that could be done easily enough.

Thanks for looking,
-Nathan
