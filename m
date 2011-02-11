Return-Path: <meador_inge@mentor.com>
Message-ID: <4D55736D.2070606@mentor.com>
Date: Fri, 11 Feb 2011 11:35:41 -0600
From: Meador Inge <meador_inge@mentor.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <B08248@freescale.com>
Subject: Re: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>	<AANLkTinda9TX+Ng=kL-HHLOdqRnUZ6uitQKyZcRUHVco@mail.gmail.com>	<4D54986A.60907@mentor.com>	<AANLkTikPgqgnWDOz+H5OXK7Sc=J67xOF3NMNkfDErocu@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E15030C485D@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15030C485D@039-SN1MPN1-002.039d.mgd.msft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Meador Inge <meadori@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2011 08:58 AM, Yoder Stuart-B08248 wrote:
>
>
>> -----Original Message-----
>> From: Meador Inge [mailto:meadori@gmail.com]
>> Sent: Thursday, February 10, 2011 9:26 PM
>> To: Benjamin Herrenschmidt
>> Cc: Yoder Stuart-B08248; devicetree-discuss@lists.ozlabs.org; linuxppc-
>> dev@lists.ozlabs.org
>> Subject: Re: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
>>
>> Apologies for the bad post.  Bad day for email ...  Please ignore the top
>> reply in my previous reply.  The full reply is the below the quote.
>>
>> On Thu, Feb 10, 2011 at 8:01 PM, Meador Inge<meador_inge@mentor.com>
>> wrote:
>>>
>>> On 02/10/2011 02:42 PM, Meador Inge wrote:
>>>>
>>>> ---------- Forwarded message ----------
>>>> From: Meador Inge<meador_inge@mentor.com>
>>>> Date: Fri, Feb 4, 2011 at 5:25 PM
>>>> Subject: [PATCH v3 0/4] powerpc: Open PIC binding and "pic-no-reset"
>>>> To: linuxppc-dev@lists.ozlabs.org
>>>> Cc: devicetree-discuss@lists.ozlabs.org, Hollis Blanchard<
>>>> hollis_blanchard@mentor.com>
>>>>
>>>>
>>>> This patch set provides a binding for Open PIC and implements support
>>>> for a new property, specified by that binding, called "pic-no-reset".
>>>> With "pic-no-reset" in place the "protected-sources" property is no
>>>> longer needed and its full implementation was removed.
>>>> "protected-sources" is still checked for, however, for legacy
>>>> purposes.
>>>>
>>>> For v3 of this patch the Open PIC binding was changed to be more
>>>> consistent with existing bindings, several DTS files were cleaned up,
>>>> "no-reset" was changed to "pic-no-reset", and a check to treat
>>>> "protected-sources" as a synonym for "pic-no-reset" was added.
>>>>
>>
>>  From the feedback I have received so far, the fundamental ideas in this
>> patch set are sane.  However, the following issues still need agreement:
>>
>>      1. What should be the name of the no reset property?
>>         "pic-no-reset" or "no-reset"?
>>      2. Should we just keep the existing protected sources implementation
>>         in place?
>>
>> For (1), I prefer "no-reset".
>
> I also prefer plain "no-reset".  The property is on a pic node so
> "pic" on the property seems redundant.
>
>> For (2), I still think that we can make "no-
>> reset" a synonym for "protected-sources" and that things will work out.
>>
>> Ben, you said that you would really like to leave the protected sources
>> implementation alone.  Is the mechanism implemented in "PATCH
>> v3 3/4" [1] of having "protected-sources" as a synonym for "pic-no-reset"
>> not suitable?
>
> I thought what Ben was getting at was that there is existing
> firmware that may provide a device tree with protected-sources,
> and thus we should continue supporting it for backwards
> compatibility.

Yup, Arnd pointed that out as well.  That is why in "PATCH v3 3/4" I 
added a check for "protected-sources".  If it is found, then it is 
treated exactly the same way as "no-reset", which should give equivalent 
behavior.

For example, say we have 100 sources and the sources [1, 50] are the 
only ones actually mentioned in the device tree.  Also assume we set 
"protected-sources = <51 52 53>".

Then, with the protected sources model sources [1, 50] and [54, 100] 
would have there VECPRI/cpu binding initialization.  Where as in the 
enhanced "no-reset" model, only sources [1, 50] would have the 
initialization done.

So unless there is some problem with not initializing the remaining 
sources, e.g. sources [51, 100] in the previous example, then the 
expanded "no-reset" should offer equivalent behavior to "protected-sources".

> So, I would say add "no-reset" as the preferred mechanism
> going forward, but keep "protected-sources" for backwards
> compatibility.
>
> Stuart
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss


-- 
Meador Inge     | meador_inge AT mentor.com
Mentor Embedded | http://www.mentor.com/embedded-software
