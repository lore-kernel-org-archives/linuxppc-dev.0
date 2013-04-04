Return-Path: <paulus@ozlabs.org>
Date: Thu, 4 Apr 2013 14:34:36 +1100
From: Paul Mackerras <paulus@samba.org>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/11] Add PRRN Event Handler
Message-ID: <20130404033436.GC19443@drongo>
References: <51509AE8.8070803@linux.vnet.ibm.com>
 <51509CF0.10200@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51509CF0.10200@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 25, 2013 at 01:52:32PM -0500, Nathan Fontenot wrote:
> From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
> 
> A PRRN event is signaled via the RTAS event-scan mechanism, which
> returns a Hot Plug Event message "fixed part" indicating "Platform
> Resource Reassignment". In response to the Hot Plug Event message,
> we must call ibm,update-nodes to determine which resources were
> reassigned and then ibm,update-properties to obtain the new affinity
> information about those resources.
> 
> The PRRN event-scan RTAS message contains only the "fixed part" with
> the "Type" field set to the value 160 and no Extended Event Log. The
> four-byte Extended Event Log Length field is repurposed (since no
> Extended Event Log message is included) to pass the "scope" parameter
> that causes the ibm,update-nodes to return the nodes affected by the
> specific resource reassignment.
> 
> This patch adds a handler in rtasd for PRRN RTAS events. The function
> pseries_devicetree_update() (from mobility.c) is used to make the
> ibm,update-nodes/ibm,update-properties RTAS calls. Updating the NUMA maps
> (handled by a subsequent patch) will require significant processing,
> so pseries_devicetree_update() is called from an asynchronous workqueue
> to allow rtasd to continue processing events. Since we flush all work
> on the queue before handling any new work there should only be one event
> in flight of being handled at a time.
            ^^ "of" is superfluous

In the worst case where PRRN events come close together in time, the
flush_work will block for however long it takes to do this
"significant processing", meaning that we're no better off using a
workqueue.  Do we have any reason to think that these PRRN events will
normally be widely spaced in time?  If so you should mention it in the
patch description.

Also, rtasd isn't actually a task, it's just a function that gets run
via schedule_delayed_work_on() and re-schedules itself each time it
runs.  Is there any deadlock possibility in calling flush_work from a
work function?

Paul.
