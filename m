Date: Fri, 28 Sep 2001 10:41:23 -0700
Subject: Re: Problem serial.c on module
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v472)
Cc: "KOBAYASHI R. Taizo" <tkoba@ike-dyn.ritsumei.ac.jp>,
	linuxppc-dev@lists.linuxppc.org
To: Tom Rini <trini@kernel.crashing.org>
From: "David A. Gatwood" <dgatwood@apple.com>
In-Reply-To: <20010928081508.S23005@cpe-24-221-152-185.az.sprintbbd.net>
Message-Id: <08F1F38A-B438-11D5-9814-003065B90BBC@apple.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Friday, September 28, 2001, at 08:15 AM, Tom Rini wrote:

> On Fri, Sep 28, 2001 at 02:33:01PM +0900, KOBAYASHI R. Taizo wrote:
>
>> I examined this problem and had a question.
>> Dose it need following branch?
>> ================L5375==
>> #ifdef CONFIG_ALL_PPC
>>         /* early PowerMacs would machine check */
>>         if (_machine == _MACH_Pmac) {
>>                 printk(KERN_INFO "serial.c: nothing to do on
>> PowerMacs.\n");
>>                 return 0;
>>         }
>> #endif
>> =======================
>
> Some older machines apparently do.  The current 'workaround' in 2_4 is
> #if defined(CONFIG_ALL_PPC) && !defined(MODULE).

That's disgusting.  This should be doing the Linux equivalent of setjmp
and trapping the machine check and returning 0.  Hardware probes
shouldn't need hacks like this.  Just my $0.02.


David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
