Message-ID: <393FB55F.4CE6988@snmc.com>
Date: Thu, 08 Jun 2000 10:01:51 -0500
From: Daris Nevil <Daris.Nevil@snmc.com>
MIME-Version: 1.0
To: Greg Johnson <gjohnson@research.canon.com.au>
CC: Linux PPC Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Task Queues
References: <20000608042335.85655415FA@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greg,

Not sure what is going wrong for you, but I can show you what
works for me.

Somewhere in your device driver data structure (or as a static
variable) create a task queue:

    struct tq_struct bh_tq;

In your driver initialization function, initialize the task queue:

    static void bottom_half_handler(void* dev);

    bh_tq.routine = bottom_half_hander;
    bh_tq.data = (void*)dev; // Or pass whatever data structure you will need

Then, when you are ready to place your function in the queue:

    queue_task(&bh_tq, &tq_immediate);
    mark_bh(IMMEDIATE_BH); // This might be the step you are missing

The mark_bh() function sets a flag that tells the scheduler it needs to
run the list of functions in the tq_immediate queue.

Hope this helps.

Regards,
Daris Nevil
SiSIC Inc/SNMC
www.snmc.com

Greg Johnson wrote:

> Hi All,
>
> I am trying to create an ISR for our hardware that implements a
> "bottom half" interrupt handler. I use a task queue to do this
> since our driver is a loadable module. Everything works fine
> except that if the task is added to the tq_immediate task queue
> it does not seem to run. If I use the tq_scheduler task queue
> it works fine. I gather that for bottom halfves that it is
> appropriate to schedule them on the immediate queue.
>
> I have also tried running other tasks that are scheduled elsewhere
> in the driver, and have the same problem.
>
> Thanks
>
> Greg.
>
> --
> +------------------------------------------------------+
> | Do you want to know more? www.geocities.com/worfsom/ |
> |              ..ooOO Greg Johnson OOoo..              |
> | HW/SW Engineer        gjohnson@research.canon.com.au |
> | Canon Information Systems Research Australia (CISRA) |
> | 1 Thomas Holt Dr., North Ryde, NSW, 2113,  Australia |
> |      "I FLEXed my BISON and it went YACC!" - me.     |
> +------------------------------------------------------+
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
