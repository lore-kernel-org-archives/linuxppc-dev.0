In-Reply-To: <BAY19-F12mLng8FSZDh0000bc92@hotmail.com>
References: <BAY19-F12mLng8FSZDh0000bc92@hotmail.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6764CBDA-A5EE-11D8-9559-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: kernel thread and NULL active_mm (MPC860)
Date: Fri, 14 May 2004 17:33:56 -0400
To: "Lee Rhodes" <daddy_rhodes@hotmail.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On May 14, 2004, at 11:20 AM, Lee Rhodes wrote:

> Can anyone tell me what would cause my kernel thread to have a NULL
> active_mm?

Good question.  The active_mm is used by lazy TLB management, which
we don't do on PowerPC.  We don't use this data structure field for any
of our MMU processing.  It's managed by generic code in the scheduler
and process management functions, there isn't any PowerPC specific
code that uses or changes it.  I thought at one time I traced a path
through
the scheduler that would cause active_mm to be NULL for kernel threads
under certain conditions, but since we didn't use it, I didn't care.
That
code always make my head hurt.

It would help if you indicate what versions of kernel you are using in
both cases and where you got them.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
