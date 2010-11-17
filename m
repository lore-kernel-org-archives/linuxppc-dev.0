Return-Path: <diggskevin38@gmail.com>
MIME-Version: 1.0
In-Reply-To: <AANLkTin1wdo1e9nt07H+UkQmKWSvnKa+CHzwuQ8F2gR1@mail.gmail.com>
References: <AANLkTiksY8x7XOifU3FAAPpCa_h4oEBmqu_a0vjRE5h5@mail.gmail.com>
	<1289255477.2147.1368.camel@pasglop>
	<AANLkTin1wdo1e9nt07H+UkQmKWSvnKa+CHzwuQ8F2gR1@mail.gmail.com>
Date: Wed, 17 Nov 2010 16:52:57 -0600
Message-ID: <AANLkTinWry94YidZRu_4nr1ahgPiVV06g+zh_zDF8iGQ@mail.gmail.com>
Subject: Re: PowerMac8600 help ...
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I have managed to boot the G4 (GigE) using a kernel built with the
4.3.5 compiler on the 8600. I have also discovered what prevented
firefox from working with 4.3.5. It was picking up the 3.4.6 libstdc++
(possibly other internal tidbits as well). Even something as simple
as:

#include <iostream>
#include <string>
using namespace std;

inline void pr_message(string s="Hello world!")  {
cout<<s<<endl;
}

int main()
{
pr_message();
}

Won't run using 4.3.5 and the libstdc++ from 3.4.6. They were both
installed because I used 3.4.6 to build 4.3.5 after discovering that
3.4.6 can't build the kernel either.

So ... I am back to why I can't get a newer kernel running on the 8600???

Thanks!

kevin

P.S.:  newer powermacs have a line in cpuinfo, like "PowerMac 7,2".
Does this uniquely identify a particular model?

On 11/11/10, kevin diggs <diggskevin38@gmail.com> wrote:
> Ben,
>
> Thanks for taking the time to reply. I tried removing some memory that
> I "suspect" might be "less than ideal". The result was the same. So I
> don't think the problem is memory related. Also the latest firefox
> build using gcc 4.3.5 I tried was with CFLAGS="-O0 -mcpu=powerpc".
> This should chew up less memory than a gcc 3.4.6 build with "-O2
> -mcpu=750 -mmultiple", right?
>
> I'm gonna switch to the GigE and try a 2.6.36 with the 8600 config and
> a firefox build using 4.3.5. The GigE has an hd5500 HDTV card in it!
>
> Thanks again for taking the time to try to help!
>
> kevin
>
> P.S.:  I have discovered that one should not build firefox with
> -mpowerpc-gpopt for a 750GX cauz it ain't not got no hardware fsqrt!
> Off the top of your head would you know which of the ppc32 processors
> has fsqrt? Is it only the 604?
>
> On Mon, Nov 8, 2010 at 4:31 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>> On Mon, 2010-11-08 at 10:43 -0600, kevin diggs wrote:
>>>
>>> Sorry for the noise but I am having trouble getting the latest kernel
>>> built for a PowerMac8600 with a 750GX processor card. If this is not
>>> an appropriate topic for the list please tell me (and hopefully point
>>> me in the correct direction).
>>>
>>> I have narrowed the problem down to the compiler. YDL 4.0 is installed
>>> on the machine. The stock compiler is 3.3.3. That version can NOT
>>> build past 2.6.28. I built 3.4.6, (the latest 3 series I could find).
>>> It can NOT build later kernel versions either. It can build Firefox
>>> 2.0.0.15pre, including powerpc thin lock support. Running it now.
>>>
>>> I then tried 4.3.5. This will build the kernel. But the resulting
>>> kernel will NOT run. A firefox built with 4.3.5 also will not run. Or
>>> if it runs it crashes often (http://abcnews.com).
>>>
>>> What really puzzles me is I used the same basic compiler boot
>>> strapping (3.3.3 to build 3.4.6, 3.4.6 to build 4.3.5) on a GiGE. That
>>> machine is now running 2.6.36.
>>>
>>> The CFLAGS used were:  "-O2 -mcpu=7450 -mmultiple -mstring" for the
>>> GiGE (dual 7455s). Substitute 750 for the 8600.
>>>
>>> Any suggestions would be appreciated.
>>
>> This is odd... I wonder if your 8600 is having some memory problems ?
>>
>> Have you tried using the kernel/firefox built with 4.3.5 on the GigE and
>> booting them on the 8600 ?
>>
>> 3.x are ancient but I would expect 4.3.x to work just fine
>>
>> Cheers,
>> Ben.
>>
>>
>>
>
