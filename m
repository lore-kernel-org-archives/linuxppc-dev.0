In-Reply-To: <20040510213336.GA4496@mars.ravnborg.org>
References: <20040510205808.GA4313@mars.ravnborg.org> <548E72DE-A2C7-11D8-95B9-003065F9B7DC@embeddededge.com> <20040510213336.GA4496@mars.ravnborg.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <42CE42B9-A2EE-11D8-95B9-003065F9B7DC@embeddededge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Efficient handling of RTP frames?
Date: Mon, 10 May 2004 21:55:21 -0400
To: Sam Ravnborg <sam@ravnborg.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 10, 2004, at 5:33 PM, Sam Ravnborg wrote:

> But I still do not see how the two drivers can 'communicate',
> or what other requirements is put on the driver that communicate
> with the DSP.

Since you are using RTP over UDP, you are going to use the
network stack, so the drivers aren't going to "communicate"
directly.  You can use some FCC/TDM interface to format the
data for the DSP, then use an application to do the rest.
The driver for the DSP will have to be something custom, then
you can configure the FCC Ethernet to handle small frames by
increasing the number of ring buffers (but don't go too high or
that overhead will get too high) and use the NAPI to reduce the
interrupt overhead.  Depending upon the performance requirements,
the custom DSP driver could be implemented to share buffers
directly with the application.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
