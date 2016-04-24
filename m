Return-Path: <runaway@candw.ms>
Received: from smtp754.redcondor.net (smtp754.redcondor.net [208.80.206.54])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qt8kF5RPCzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Apr 2016 23:06:11 +1000 (AEST)
Subject: Re: [PATCH v1 00/23] ata: sata_dwc_460ex: make it working again
To: Christian Lamparter <chunkeey@googlemail.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <571B6444.9060505@candw.ms> <571B9849.2040406@candw.ms>
 <4252844.GfFuvxr01B@debian64>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?=
 <mans@mansr.com>
From: Julian Margetson <runaway@candw.ms>
Message-ID: <571CC4A7.8050808@candw.ms>
Date: Sun, 24 Apr 2016 09:05:43 -0400
MIME-Version: 1.0
In-Reply-To: <4252844.GfFuvxr01B@debian64>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/23/2016 3:41 PM, Christian Lamparter wrote:
> On Saturday, April 23, 2016 11:44:09 AM Julian Margetson wrote:
>> On 4/23/2016 8:02 AM, Julian Margetson wrote:
>>> On 4/22/2016 7:06 AM, Christian Lamparter wrote:
>>>> On Friday, April 22, 2016 06:50:44 AM Julian Margetson wrote:
>>>>> On 4/21/2016 4:25 PM, Christian Lamparter wrote:
>>>>>> On Thursday, April 21, 2016 09:15:21 PM Andy Shevchenko wrote:
>>>>>>> The last approach in the commit 8b3444852a2b ("sata_dwc_460ex:
>>>>>>> move to generic
>>>>>>> DMA driver") to switch to generic DMA engine API wasn't tested on
>>>>>>> bare metal.
>>>>>>> Besides that we expecting new board support coming with the same
>>>>>>> SATA IP but
>>>>>>> with different DMA.
>>>>>>>
>>>>>>> The driver has been tested myself on Sam460ex and WD MyBookLive
>>>>>>> (apollo3g)
>>>>>>> boards. In any case I ask Christian, Måns, and Julian to
>>>>>>> independently test and
>>>>>>> provide Tested-by tag or error report.
>>>>>> I did a test run on my WD MyBook Live. I applied all the patches in
>>>>>> this series on top of the topic/dw branch of Vinod Koul:
>>>>>> <https://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/>
>>>>>>
>>>>>> Tested-by: Christian Lamparter<chunkeey@googlemail.com>
>>>>>> ---
>>>>>> results for my old ST3808110AS HDD. filesystem is ext4.
>>>>>>
>>>>>> # hdparm -t /dev/sda
>>>>>>
>>>>>> /dev/sda:
>>>>>>     Timing buffered disk reads: 204 MB in  3.02 seconds = 67.51 MB/sec
>>>>>>
>>>>>> # bonnie++ -u mbl
>>>>>> Using uid:1000, gid:1000.
>>>>>> Writing a byte at a time...done
>>>>>> Writing intelligently...done
>>>>>> Rewriting...done
>>>>>> Reading a byte at a time...done
>>>>>> Reading intelligently...done
>>>>>> start 'em...done...done...done...done...done...
>>>>>> Create files in sequential order...done.
>>>>>> Stat files in sequential order...done.
>>>>>> Delete files in sequential order...done.
>>>>>> Create files in random order...done.
>>>>>> Stat files in random order...done.
>>>>>> Delete files in random order...done.
>>>>>> Version  1.97       ------Sequential Output------ --Sequential
>>>>>> Input- --Random-
>>>>>> Concurrency   1     -Per Chr- --Block-- -Rewrite- -Per Chr-
>>>>>> --Block-- --Seeks--
>>>>>> Machine        Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec
>>>>>> %CP  /sec %CP
>>>>>> mbl            496M    98  99 26011  21 17589  20   538  99 80138
>>>>>> 39 208.9   8
>>>>>> Latency             95267us    1409ms     295ms   26947us 9644us
>>>>>> 1787ms
>>>>>> Version  1.97       ------Sequential Create------ --------Random
>>>>>> Create--------
>>>>>> mbl                 -Create-- --Read--- -Delete-- -Create--
>>>>>> --Read--- -Delete--
>>>>>>                  files  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec
>>>>>> %CP  /sec %CP
>>>>>>                     16  6959  78 +++++ +++  5197  40  7250 79 +++++
>>>>>> +++  4718  37
>>>>>> Latency               149ms    6742us     212ms 177ms     767us
>>>>>> 217ms
>>>>>> 1.97,1.97,mbl,1,1461269771,496M,,98,99,26011,21,17589,20,538,99,80138,39,208.9,8,16,,,,,6959,78,+++++,+++,5197,40,7250,79,+++++,+++,4718,37,95267us,1409ms,295ms,26947us,9644us,1787ms,149ms,6742us,212ms,177ms,767us,217ms
>>>>>>
>>>>>>
>>>>> Again on copy partitions .
>>>> Ok, here's the copy from my mail off-list.
>>>>
>>>> Well, a unrelated driver "m41t80" caused a crash:
>>>> [   12.912739] Oops: Kernel access of bad area, sig: 11 [#3]
>>>> [   12.912743] PREEMPT Canyonlands
>>>> [   12.912753] CPU: 0 PID: 1413 Comm: irq/45-m41t80 Tainted: G
>>>> D         4.6.0-rc4-next-20160421-sam460ex-jm #1
>>>> [   12.912757] task: ea9834e0 ti: eea6c000 task.ti: eea6c000
>>>> [   12.912760] NIP: c0224480 LR: c0023494 CTR: c0042508
>>>> [   12.912764] REGS: eea6daf0 TRAP: 0300   Tainted: G D
>>>> (4.6.0-rc4-next-20160421-sam460ex-jm)
>>>> [   12.912774] MSR: 00029000 <CE,EE,ME>  CR: 24008282 XER: 00000000
>>>> [   12.912825] DEAR: 00000008 ESR: 00000000
>>>> [...]
>>>> [   12.912927] --- interrupt: 300 at mutex_lock+0x0/0x1c
>>>> [   12.912927]     LR = m41t80_handle_irq+0x28/0xac
>>>> [   12.912932] [eea6de40] [00000000]   (null) (unreliable)
>>>> [   12.912938] [eea6de60] [c004ffac] irq_thread_fn+0x2c/0x48
>>>> [   12.912944] [eea6de80] [c00501cc] irq_thread+0xc4/0x160
>>>> [   12.912951] [eea6ded0] [c003a3f8] kthread+0xc8/0xcc
>>>> [   12.912957] [eea6df40] [c000aee8] ret_from_kernel_thread+0x5c/0x64
>>>> [   12.912960] Instruction dump:
>>>> [   12.912974] 80010014 7fc3f378 bbc10008 7c0803a6 38210010 4be24ca8
>>>> 9421ffd0 7c0802a6
>>>> [   12.912987] bf210014 90010034 3b4302d8 812302ec <83890008>
>>>> 812302d8 7f9a4840 419e011c
>>>> [   12.912995] Fixing recursive fault but reboot is needed!
>>>>                    ^^^ "reboot is needed!"
>>>>
>>>> Another thing that came to my mind: Have you checked if your hard drive
>>>> and the cables are ok? Are there any pending sectors or suspicious smart
>>>> values? Has the drive passed the extended offline test?
>>>>    Otherwise, I can't reproduce the error with my MyBook system. I've
>>>> tested
>>>> your kernel and it worked on the device without crashing. (I
>>>> copied/dd'ed
>>>> 80GB from and back to the hard-drive. It was long and boring, but I
>>>> didn't
>>>> encounter any issues and the crc32 matched).
>>>>
>>>> Sorry, but I can't help you if I can't reproduce it... And short of
>>>> sending
>>>> your box to test, I see no efficient way to debug it. However, what I
>>>> can
>>>> do, if you are interested: I have a few "build your own" My Book Live
>>>> kits.
>>>> It just needs a 3.5" hard-drive and 12v power adapter. If you are
>>>> interested
>>>> PM me off-list, this way you can verify that the kernels you build do
>>>> work,
>>>> just in case this error is due to a hardware issue (zapped controller,
>>>> bad ram/drive/cable?) with your sam460ex box.
>>>>
>>>> Regards,
>>>> Christian
>>>>
>>>>
>>> My Hardware seems ok.
>>> I have swapped cables and drives between the SII3512 pci controller
>>> and the DWC controller.
>>> No issues when connected to the SII3512 pci controller .
>>> The DWC controller works ok under AmigaOS 4.1FE so that does not
>>> appear to be a problem.
>>>
>>> Regards
>>> Julian
>>>
>>>
>>>
>>>
>>>
>>>
>> Test with kernel compiled with no other sata controllers included.
>> Freshly formatted harddrive  with one ntfs partition. MS-DOs partition
>> table.
>> Booted from USB thumb drive.
>> Keyboard and mouse freeze as soon as gparted is run.
>>
> Well, then. Have you checked for any errata for the sam460ex?
> There's a known errata for the 460EX, with the CPU lockup upon
> high AHB traffic:
> <http://lists.denx.de/pipermail/u-boot/2008-June/036078.html>
>
> "This patch implements a fix provided by AMCC so that the lockup upon
> simultanious traffic on AHB USB OTG, USB 2.0 and SATA doesn't occur
> anymore:..."
>
> This should be fixed by u-boot. However, there's no telling if
> there's more to this workaround in the dma engine. You could try
> to do the testing without anything connected to the USB ports
> and disable/remove all usb hcds modules. As for fixing this:
> I did a quick search but couldn't find any public information.
> There's always support@apm.com (contact them!), or maybe someone
> from the Amiga community knows more?
>
>

Tested with kernel with all USB disabled.
No sata error messages during the partition copy  but the copying is 
quite slow .
so this does appear to be the problem .

Regards
Julian
