Message-ID: <3F155AC2.5000301@embeddededge.com>
Date: Wed, 16 Jul 2003 10:01:38 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Darin.Johnson@nokia.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] consistent_sync and non L1 cache line aligned buffers
References: <F0B628F30F48064289D8CCC1EE21B7A80C48A8@mvebe001.americas.nokia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Darin.Johnson@nokia.com wrote:

> My headache example was the 4 byte buffer that MPC860 CPM
> was using to talk to an I2C device, there just wasn't an
> elegant solution...

You should have used consistent_alloc and never used consistent_sync()
in this case.  FYI, consistent_sync() should never be used on
consistent_alloc()'ed buffers.....another tidbit for documentation.
The consistent_* are used to manage a variety of consistency related
features of non-coherent processors, not that you should necessarily
use all of them to solve a particular implementation requirement.

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
