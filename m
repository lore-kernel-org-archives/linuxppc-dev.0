Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6EBC61A06BD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 17:16:12 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/pseries/hvcserver: don't memset pi_buff if it is
 null
To: Daniel Axtens <dja@axtens.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <1444330858-5508-1-git-send-email-colin.king@canonical.com>
 <878u7853g7.fsf@gamma.ozlabs.ibm.com>
Cc: linux-kernel@vger.kernel.org
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <561B4FCC.5080907@canonical.com>
Date: Mon, 12 Oct 2015 07:14:36 +0100
MIME-Version: 1.0
In-Reply-To: <878u7853g7.fsf@gamma.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 12/10/15 01:35, Daniel Axtens wrote:
> 
> Hi Colin,
> 
> This looks good. Out of curiousity, how did you find it? Code
> inspection? Bug? Static analysis?

static analysis with cppcheck. I forgot to mention that in the commit
message.

> 
> Not that it's particularly meaningful for such a trivial fix, but FWIW
:
> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> 
> Regards,
> Daniel
> 
> Colin King <colin.king@canonical.com> writes:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> pi_buff is being memset before it is sanity checked. Move the
>> memset after the null pi_buff sanity check to avoid an oops.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  arch/powerpc/platforms/pseries/hvcserver.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/hvcserver.c b/arch/powerp
c/platforms/pseries/hvcserver.c
>> index eedb645..94a6e56 100644
>> --- a/arch/powerpc/platforms/pseries/hvcserver.c
>> +++ b/arch/powerpc/platforms/pseries/hvcserver.c
>> @@ -142,11 +142,11 @@ int hvcs_get_partner_info(uint32_t unit_address
, struct list_head *head,
>>  	int more = 1;
>>  	int retval;
>>  
>> -	memset(pi_buff, 0x00, PAGE_SIZE);
>>  	/* invalid parameters */
>>  	if (!head || !pi_buff)
>>  		return -EINVAL;
>>  
>> +	memset(pi_buff, 0x00, PAGE_SIZE);
>>  	last_p_partition_ID = last_p_unit_address = ~0UL;
>>  	INIT_LIST_HEAD(head);
>>  
>> -- 
>> 2.5.0
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJWG0/KAAoJEGjCh9/GqAImcV8QAIToDexS4X/vya3F8aHZ2qtT
idFEvgKl1mJxzgk79RJs874AiGs3CtOEC3/5w5fMh4eA/P6d6vJ1NPDu5bsugzzA
I6F329WP/QxeOWgU13GSXxa0p13sUxTXqFRT8sHqwDgEaecX6kR+nf8x+P5pZUYX
c7y25IHCZ/nNrj/QwQZcrlNd+U5bwxHyd5zUPJYYInbSEQmPUrhFhW1EkiUDVEYG
6rGmCzRGqfPS2sBqLXG/6ObP4FO8NC+bxQxNWAG/p9iWZg9KdIVL7IFTjWbxT7GC
dsVbBsWu7ewUqo6euK56cd5CFf0oFDoHwhbDQ7T9b9CHYvGVWHxW1k7rUCgcep9x
yJIIWOAVw78DemV3JkZm53Q2+1jUCYuaY6Vw8M3UmdQbWrg2rvbh8TtgoCiXbbrF
HlNO0wlFOBpmr7LoHEPoIV8TsIeoeEikGrXszkqXI/MXKvN8jW1k5vtzcD3j+EU9
gy9wZvovvVZ6RL0erXwVLdzDp+R2clQfIcSi/St2/OGW+5X9NXtuaa+mvBy+dcpW
Se0kO8DpLmHfNtcXvXJhCm77O1Oapw7s5UumevXSTibZ/Mhxzrdg+YhSWexm/SRu
evcm6pagTpX3Vruq4BTt0Rdji9J/stT8GFlOWT0hGH1ZBLrzIKTlkJskSTkT801N
+MkiI6UyL8lqdVoqZrNk
=xqJ4
-----END PGP SIGNATURE-----
