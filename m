Return-Path: <srinivas.kandagatla@st.com>
Message-ID: <5056D1E6.2010804@st.com>
Date: Mon, 17 Sep 2012 08:31:50 +0100
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2 3/7] dt/powerpc/powernv: Use of_get_child_by_name to
 get a named child.
References: <1347610743-20189-1-git-send-email-srinivas.kandagatla@st.com>
 <1347847668.28674.3.camel@concordia>
In-Reply-To: <1347847668.28674.3.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com,
 linuxppc-dev@lists.ozlabs.org
Reply-To: srinivas.kandagatla@st.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 17/09/12 03:07, Michael Ellerman wrote:
> On Fri, 2012-09-14 at 09:19 +0100, Srinivas KANDAGATLA wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>>
>> As follow-up to "dt: introduce of_get_child_by_name to get child node by
>> name." patch, This patch removes some of the code duplication in the
>> driver by replacing it with of_get_child_by_name instead.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>> ---
>>  arch/powerpc/platforms/powernv/opal.c |    6 ++----
>>  1 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index aaa0dba..6dfb8af 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -294,11 +294,9 @@ static int __init opal_init(void)
>>  		consoles = of_node_get(opal_node);
>>  
>>  	/* Register serial ports */
>> -	for_each_child_of_node(consoles, np) {
>> -		if (strcmp(np->name, "serial"))
>> -			continue;
>> +	np = of_get_child_by_name(consoles, "serial");
>> +	if (np)
>>  		of_platform_device_create(np, NULL, NULL);
>> -	}
>>  	of_node_put(consoles);
> You've introduced a refcounting bug here.
>
> The return value of of_get_child_by_name() has its refcount elevated
> (via of_node_get()), so you have to drop that reference with
> of_node_put().
I agree..
Will take care of it in v3 patch-series.
> The old code was safe because it only used np inside the loop, and the
> loop logic deals with dropping the refcount for you.
>
> And yes of_platform_device_create() takes a reference for itself.
>
> cheers
>
>
>
